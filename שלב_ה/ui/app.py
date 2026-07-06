import os
import subprocess
import dearpygui.dearpygui as dpg

SIDEBAR_WIDTH = 200
FONT_PATH = "/usr/share/fonts/abattis-cantarell-fonts/Cantarell-Regular.otf"
FONT_BOLD_PATH = "/usr/share/fonts/abattis-cantarell-fonts/Cantarell-Bold.otf"
FONT_SIZE = 26
HEADER_SIZE = 36

ASSETS_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "assets")


class BetMasterApp:
    TABLE_GROUPS = {
        "Core Betting": ["users", "teams", "matches", "odds", "bets", "transactions"],
        "Football": [
            "football_players", "football_goalkeepers",
            "football_player_contracts", "football_player_match_stats",
            "football_gk_match_stats", "football_coaches",
            "football_coach_contracts", "football_referees",
            "football_match_referees", "football_stadiums",
            "football_match_stadiums", "football_team_home_stadiums",
        ],
        "Received Football": [
            "team", "player", "goalkeeper", "playsfor_player", "playsfor_gk",
            "playermatchstats", "gkmatchstats", "coach", "coachedby",
            "referee", "refereeat", "stadium", "match", "matchteam",
            "matchstadium",
        ],
        "Integration": ["integration_sources", "integration_team_map", "integration_match_map"],
        "Audit & Risk": ["account_audit_log", "risk_review_queue", "match_settlement_log", "odds_audit_log"],
    }

    def __init__(self, repo):
        self.repo = repo
        self.current_table = None
        self.current_screen = "welcome"
        self.table_offset = 0
        self.all_rows = []
        self.search_term = ""
        self.search_cols = None
        self.client_user_id = None
        self.client_user_name = None
        self.icon_textures = {}

    def run(self):
        dpg.create_context()
        dpg.create_viewport(title="BetMaster — Football Betting Management", width=1600, height=1000)
        self._setup_fonts()
        self._load_textures()
        self._setup_theme()
        self._create_layout()
        dpg.set_primary_window("main_window", True)
        dpg.set_viewport_clear_color((15, 60, 22))
        dpg.setup_dearpygui()
        dpg.show_viewport()
        dpg.start_dearpygui()
        dpg.destroy_context()

    def _setup_fonts(self):
        if os.path.exists(FONT_PATH):
            with dpg.font_registry():
                default_font = dpg.add_font(FONT_PATH, FONT_SIZE)
                dpg.bind_font(default_font)
            if os.path.exists(FONT_BOLD_PATH):
                with dpg.font_registry():
                    dpg.add_font(FONT_BOLD_PATH, HEADER_SIZE, tag="header_font")

    def _setup_theme(self):
        # Football pitch theme — green, black & white, red & gold
        bg = (20, 80, 30, 240)           # deep grass green
        panel = (10, 50, 18, 235)         # darker green
        accent = (255, 255, 255)          # white
        accent_hover = (220, 220, 220)
        accent_active = (180, 180, 180)
        text = (240, 245, 240)            # off-white
        text_dim = (150, 190, 155)        # muted green
        success = (50, 200, 60)           # bright green
        warning = (230, 190, 20)          # yellow card
        danger = (220, 40, 40)            # red card
        border = (40, 120, 50)            # medium green
        gold = (220, 180, 30)            # gold accent

        with dpg.theme() as global_theme:
            with dpg.theme_component(dpg.mvAll):
                dpg.add_theme_color(dpg.mvThemeCol_WindowBg, bg)
                dpg.add_theme_color(dpg.mvThemeCol_ChildBg, panel)
                dpg.add_theme_color(dpg.mvThemeCol_Text, text)
                dpg.add_theme_color(dpg.mvThemeCol_TextDisabled, text_dim)
                dpg.add_theme_color(dpg.mvThemeCol_Border, border)
                dpg.add_theme_color(dpg.mvThemeCol_BorderShadow, (0, 0, 0, 0))
                dpg.add_theme_color(dpg.mvThemeCol_Button, (200, 40, 40))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonHovered, (220, 60, 60))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonActive, (180, 30, 30))
                dpg.add_theme_color(dpg.mvThemeCol_Header, (255, 255, 255, 30))
                dpg.add_theme_color(dpg.mvThemeCol_HeaderHovered, (255, 255, 255, 60))
                dpg.add_theme_color(dpg.mvThemeCol_FrameBg, (15, 60, 22))
                dpg.add_theme_color(dpg.mvThemeCol_FrameBgHovered, (20, 70, 28))
                dpg.add_theme_color(dpg.mvThemeCol_FrameBgActive, (25, 80, 32))
                dpg.add_theme_color(dpg.mvThemeCol_TitleBg, panel)
                dpg.add_theme_color(dpg.mvThemeCol_TitleBgActive, panel)
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarBg, (10, 45, 15))
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarGrab, (60, 140, 65))
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarGrabHovered, (80, 160, 85))
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarGrabActive, (100, 180, 105))
                dpg.add_theme_color(dpg.mvThemeCol_TableHeaderBg, (15, 55, 20))
                dpg.add_theme_color(dpg.mvThemeCol_TableRowBg, (10, 50, 18))
                dpg.add_theme_color(dpg.mvThemeCol_TableRowBgAlt, (14, 58, 22))
                dpg.add_theme_color(dpg.mvThemeCol_TableBorderStrong, border)
                dpg.add_theme_color(dpg.mvThemeCol_TableBorderLight, (30, 90, 38))
                dpg.add_theme_style(dpg.mvStyleVar_WindowPadding, 20, 8)
                dpg.add_theme_style(dpg.mvStyleVar_WindowRounding, 8)
                dpg.add_theme_style(dpg.mvStyleVar_ChildRounding, 8)
                dpg.add_theme_style(dpg.mvStyleVar_FrameRounding, 6)
                dpg.add_theme_style(dpg.mvStyleVar_ItemSpacing, 10, 8)
                dpg.add_theme_style(dpg.mvStyleVar_CellPadding, 8, 5)
                dpg.add_theme_style(dpg.mvStyleVar_ScrollbarSize, 12)

        dpg.bind_theme(global_theme)

        with dpg.theme(tag="success_btn") as s:
            with dpg.theme_component(dpg.mvButton):
                dpg.add_theme_color(dpg.mvThemeCol_Button, (success[0], success[1], success[2]))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonHovered, (success[0] + 20, success[1] + 20, success[2] + 20))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonActive, (success[0] - 20, success[1] - 20, success[2] - 20))

        with dpg.theme(tag="danger_btn") as d:
            with dpg.theme_component(dpg.mvButton):
                dpg.add_theme_color(dpg.mvThemeCol_Button, (danger[0], danger[1], danger[2]))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonHovered, (danger[0] + 30, danger[1] + 10, danger[2] + 10))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonActive, (danger[0] - 20, danger[1] - 10, danger[2] - 10))

        with dpg.theme(tag="warning_btn") as w:
            with dpg.theme_component(dpg.mvButton):
                dpg.add_theme_color(dpg.mvThemeCol_Button, (warning[0], warning[1], warning[2]))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonHovered, (warning[0] + 20, warning[1] + 20, warning[2] + 10))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonActive, (warning[0] - 20, warning[1] - 20, warning[2] - 10))

        with dpg.theme(tag="gold_btn") as w:
            with dpg.theme_component(dpg.mvButton):
                dpg.add_theme_color(dpg.mvThemeCol_Button, (gold[0], gold[1], gold[2]))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonHovered, (gold[0] + 15, gold[1] + 15, gold[2]))
                dpg.add_theme_color(dpg.mvThemeCol_ButtonActive, (gold[0] - 20, gold[1] - 20, gold[2]))

    # ── TEXTURE LOADING ──────────────────────────────────────────────────

    def _load_textures(self):
        png_dir = os.path.join(ASSETS_DIR, "png")

        with dpg.texture_registry():
            icon_names = [
                "sports_soccer", "wallet", "poker_chip",
                "savings", "shoe_cleats",
                "house", "travel", "handshake",
                "trophy", "leaderboard", "money_bag", "casino",
            ]
            for name in icon_names:
                p = os.path.join(png_dir, f"{name}.png")
                if os.path.exists(p):
                    w, h, c, data = dpg.load_image(p)
                    self.icon_textures[name] = dpg.add_static_texture(w, h, data, tag=f"icon_{name}")

    def _icon(self, name, width=28, height=28):
        tid = self.icon_textures.get(name)
        if tid is not None:
            dpg.add_image(tid, width=width, height=height)

    def _delete_all_children(self, tag):
        for child in dpg.get_item_children(tag, slot=1):
            dpg.delete_item(child)

    def _create_layout(self):
        with dpg.window(tag="main_window", label="BetMaster",
                        no_close=True, no_collapse=True):
            self._show_welcome()

    # ── WELCOME SCREEN ────────────────────────────────────────────────────

    def _show_welcome(self):
        self.current_screen = "welcome"
        self._delete_all_children("main_window")

        dpg.add_spacer(parent="main_window", height=40)

        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=max((1540 - 260) // 2, 5))
            self._icon("sports_soccer", 48, 48)
            dpg.add_spacer(width=12)
            dpg.add_text("BetMaster", color=(255, 255, 255))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")
        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=max((1540 - 450) // 2, 5))
            dpg.add_text("Football Betting Management System",
                         color=(140, 140, 150))
        dpg.add_spacer(parent="main_window", height=50)

        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=60)
            self._make_card("Enter as Client", 700,
                            self._show_client_select,
                            "View your profile, check bets,\n"
                            "place new bets, deposit &\n"
                            "withdraw funds.",
                            icon="wallet")
            dpg.add_spacer(width=40)
            self._make_card("System Admin Dashboard", 700,
                            self._show_admin_home,
                            "Full system management:\nbrowse & edit all 40 tables,\n"
                            "analytical queries,\nPL/pgSQL programs.",
                            icon="sports_soccer")

        dpg.add_spacer(parent="main_window", height=20)

    def _make_card(self, title, card_w, callback, desc, icon=None):
        card_h = 520
        icon_sz = 56
        content_w = card_w - 80 if card_w > 0 else 560
        desc_lines = desc.count('\n') + 1
        desc_h = desc_lines * 42 + 10
        flex_top = card_h - 40 - icon_sz - 30 - 8 - desc_h - 8 - 56 - 20
        cw = card_w - 40 if card_w > 0 else card_w
        with dpg.child_window(width=card_w, height=card_h,
                              no_scrollbar=True):
            dpg.add_spacer(height=40)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - 220) // 2, 5))
                if icon and self.icon_textures.get(icon):
                    self._icon(icon, icon_sz, icon_sz)
                    dpg.add_spacer(width=12)
                dpg.add_text(title, color=(255, 255, 255))
                if dpg.does_item_exist("header_font"):
                    dpg.bind_item_font(dpg.last_item(), "header_font")
            dpg.add_spacer(height=30)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - content_w) // 2, 5))
                dpg.add_text(desc, color=(160, 160, 170), wrap=content_w)
            dpg.add_spacer(height=max(flex_top, 5))
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - content_w) // 2, 5))
                dpg.add_button(label="Open →", width=content_w, height=56,
                               callback=callback)

    # ── NAVIGATION HELPERS ────────────────────────────────────────────────

    def _make_top_bar(self, back_label, back_callback, title, extra_buttons=None, icon=None):
        with dpg.group(horizontal=True, parent="main_window"):
            dpg.add_button(label=back_label, callback=back_callback)
            dpg.add_spacer(width=15)
            if icon and self.icon_textures.get(icon):
                self._icon(icon, 28, 28)
                dpg.add_spacer(width=6)
            dpg.add_text(title, color=(255, 255, 255))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")
            if extra_buttons:
                for btn in extra_buttons:
                    dpg.add_spacer(width=15)
                    dpg.add_button(label=btn["label"],
                                   callback=btn["callback"])
        dpg.add_separator(parent="main_window")

    def _refresh_client_dashboard(self):
        if self.client_user_id:
            self._show_client_dashboard()

    # ── CLIENT MODE ───────────────────────────────────────────────────────

    def _show_client_select(self):
        self.current_screen = "client_select"
        self.client_user_id = None
        self.client_user_name = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Welcome", self._show_welcome,
                           "BetMaster Client", icon="wallet")

        with dpg.group(parent="main_window"):
            dpg.add_spacer(height=40)

            with dpg.group(horizontal=True):
                dpg.add_spacer(width=250)
                with dpg.child_window(width=800, height=800, no_scrollbar=True):
                    dpg.add_spacer(height=60)
                    dpg.add_text("Welcome to BetMaster!",
                                 color=(255, 255, 255))
                    if dpg.does_item_exist("header_font"):
                        dpg.bind_item_font(dpg.last_item(), "header_font")
                    dpg.add_spacer(height=30)
                    dpg.add_text("Select your user account to continue:",
                                 color=(140, 140, 150))
                    dpg.add_spacer(height=15)

                    users = self.repo.get_users_for_selection()
                    items = [f"{u[0]} — {u[1]}" for u in users]
                    dpg.add_combo(tag="client_user_combo",
                                  label="User",
                                  items=items, width=500)
                    dpg.add_spacer(height=15)
                    dpg.add_input_text(tag="client_password",
                                       label="Password",
                                       password=True,
                                       width=500,
                                       default_value="")
                    dpg.add_spacer(height=20)
                    dpg.add_button(label="Enter Client Area →",
                                   width=500, height=50,
                                   callback=self._on_client_selected)

    def _on_client_selected(self):
        val = dpg.get_value("client_user_combo")
        if not val:
            return
        user_id = int(val.split(" — ")[0])
        self.client_user_id = user_id
        users = self.repo.get_users_for_selection()
        for u in users:
            if u[0] == user_id:
                self.client_user_name = u[1]
                break
        self._show_client_dashboard()

    def _show_client_dashboard(self):
        self.current_screen = "client_dashboard"
        self._delete_all_children("main_window")
        dpg.add_spacer(parent="main_window", height=10)

        self._make_top_bar(
            "← Switch User", self._show_client_select,
            f"BetMaster — {self.client_user_name}",
            extra_buttons=[
                {"label": "← Back to Welcome",
                 "callback": self._show_welcome},
            ],
            icon="wallet",
        )

        profile = self.repo.get_user_profile(self.client_user_id)
        if not profile:
            with dpg.group(parent="main_window"):
                dpg.add_text("User not found", color=(200, 60, 60))
            return

        with dpg.group(parent="main_window"):
            dpg.add_spacer(height=10)

            # ── Stats row ──
            bstats = self.repo.get_user_bet_stats(self.client_user_id)
            if bstats:
                wr = (bstats["won"] / bstats["total_bets"] * 100) if bstats["total_bets"] else 0
                with dpg.group(horizontal=True):
                    dpg.add_spacer(width=15)
                    self._render_stat_card("Total Bets", bstats["total_bets"],
                                           color=(220, 180, 30), icon="poker_chip")
                    dpg.add_spacer(width=15)
                    self._render_stat_card("Won", bstats["won"],
                                           color=(70, 190, 90), icon="trophy")
                    dpg.add_spacer(width=15)
                    self._render_stat_card("Win Rate", f"{wr:.1f}%",
                                           color=(210, 160, 50))
                    dpg.add_spacer(width=15)
                    self._render_stat_card("Total Wagered",
                                           f"${bstats['total_wagered']:,.2f}",
                                           color=(200, 120, 60), icon="money_bag")

            dpg.add_spacer(height=10)

            # ── Profile, Balance, Quick Actions ──
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=15)
                with dpg.child_window(width=400, height=150, no_scrollbar=True):
                    dpg.add_spacer(height=5)
                    with dpg.group(horizontal=True):
                        self._icon("leaderboard", 22, 22)
                        dpg.add_spacer(width=5)
                        dpg.add_text("Profile", color=(255, 255, 255))
                    dpg.add_spacer(height=6)
                    dpg.add_text(f"{profile['full_name']}  |  {profile['email']}",
                                 color=(160, 160, 170), wrap=380)
                    self._render_status_badge(profile['account_status'])
                    dpg.add_text(f"Since {profile['registration_date']}",
                                 color=(100, 100, 110))

                dpg.add_spacer(width=15)
                with dpg.child_window(width=360, height=150, no_scrollbar=True):
                    dpg.add_spacer(height=5)
                    with dpg.group(horizontal=True):
                        self._icon("wallet", 22, 22)
                        dpg.add_spacer(width=5)
                        dpg.add_text("Balance", color=(255, 255, 255))
                    dpg.add_spacer(height=8)
                    bal = profile["balance"]
                    bal_color = (70, 190, 90) if bal and bal >= 0 else (200, 60, 60)
                    dpg.add_text(f"${float(bal):,.2f}" if bal else "$0.00",
                                 color=bal_color)
                    if dpg.does_item_exist("header_font"):
                        dpg.bind_item_font(dpg.last_item(), "header_font")

                dpg.add_spacer(width=15)
                with dpg.child_window(width=600, height=150, no_scrollbar=True):
                    dpg.add_spacer(height=5)
                    with dpg.group(horizontal=True):
                        self._icon("casino", 22, 22)
                        dpg.add_spacer(width=5)
                        dpg.add_text("Quick Actions", color=(255, 255, 255))
                    dpg.add_spacer(height=10)
                    with dpg.group(horizontal=True):
                        dpg.add_button(label="  Deposit  ", width=160, height=40,
                                       callback=self._show_client_deposit)
                        dpg.add_spacer(width=12)
                        dpg.add_button(label="  Withdraw  ", width=160, height=40,
                                       callback=self._show_client_withdraw)
                        dpg.add_spacer(width=12)
                        dpg.add_button(label="  Place Bet  ", width=160, height=40,
                                       callback=self._show_client_matches)

            dpg.add_spacer(height=15)

            # ── Charts row ──
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=15)
                # Pie: bet outcomes
                dist = self.repo.get_user_bet_distribution(self.client_user_id)
                pie_labels = [r[0] for r in dist] if dist else []
                pie_vals = [float(r[1]) for r in dist] if dist else []
                with dpg.child_window(width=500, height=280, no_scrollbar=True):
                    with dpg.group(horizontal=True):
                        self._icon("poker_chip", 22, 22)
                        dpg.add_spacer(width=5)
                        dpg.add_text("Bet Outcomes", color=(255, 255, 255))
                    self._render_pie_chart(pie_vals, pie_labels, height=220, width=460)

                dpg.add_spacer(width=15)
                # Bar: recent bet amounts
                amounts_data = self.repo.get_user_bet_amounts_chart(
                    self.client_user_id, limit=12)
                bar_labels = [str(r[1])[:5] for r in amounts_data] if amounts_data else []
                bar_vals = [float(r[0]) for r in amounts_data] if amounts_data else []
                with dpg.child_window(width=540, height=280, no_scrollbar=True):
                    with dpg.group(horizontal=True):
                        self._icon("money_bag", 22, 22)
                        dpg.add_spacer(width=5)
                        dpg.add_text("Recent Bet Amounts", color=(255, 255, 255))
                    self._render_bar_chart(bar_labels, bar_vals,
                                           height=220, width=500)

                dpg.add_spacer(width=15)
                # Navigation tiles stacked vertically
                with dpg.child_window(width=300, height=280, no_scrollbar=True):
                    dpg.add_spacer(height=8)
                    dpg.add_text("Quick Navigation", color=(140, 140, 150))
                    dpg.add_spacer(height=10)
                    with dpg.group(horizontal=True):
                        self._icon("poker_chip", 22, 22)
                        dpg.add_button(label="  My Bets  ", width=230, height=44,
                                       callback=self._show_client_bets)
                    dpg.add_spacer(height=6)
                    with dpg.group(horizontal=True):
                        self._icon("sports_soccer", 22, 22)
                        dpg.add_button(label="  Available Matches  ", width=230, height=44,
                                       callback=self._show_client_matches)
                    dpg.add_spacer(height=6)
                    with dpg.group(horizontal=True):
                        self._icon("money_bag", 22, 22)
                        dpg.add_button(label="  Transaction History  ", width=230, height=44,
                                       callback=self._show_client_transactions)

            # Recent bets
            dpg.add_spacer(height=15)
            self._show_client_recent_bets()

    def _make_nav_tile(self, title, card_w, callback, desc):
        cw = card_w - 40 if card_w > 0 else card_w
        content_w = card_w - 60 if card_w > 0 else 260
        with dpg.child_window(width=card_w, height=180, no_scrollbar=True):
            dpg.add_spacer(height=20)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - 200) // 2, 5))
                dpg.add_text(title, color=(255, 255, 255))
                if dpg.does_item_exist("header_font"):
                    dpg.bind_item_font(dpg.last_item(), "header_font")
            dpg.add_spacer(height=15)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - content_w) // 2, 5))
                dpg.add_text(desc, color=(160, 160, 170), wrap=content_w)
            dpg.add_spacer(height=10)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - content_w) // 2, 5))
                dpg.add_button(label="Open →", width=content_w, height=40,
                               callback=callback)

    # ── VISUAL COMPONENTS ─────────────────────────────────────────────────

    def _render_stat_card(self, title, value, color=None, subtitle="",
                          width=340, height=160, icon=None):
        c = color or (255, 255, 255)
        cw = width - 40
        with dpg.child_window(width=width, height=height, no_scrollbar=True):
            dpg.add_spacer(height=10)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - 250) // 2, 5))
                if icon and self.icon_textures.get(icon):
                    self._icon(icon, 40, 40)
                    dpg.add_spacer(width=10)
                dpg.add_text(title, color=(180, 190, 180))
            dpg.add_spacer(height=6)
            with dpg.group(horizontal=True):
                dpg.add_spacer(width=max((cw - 250) // 2, 5))
                dpg.add_text(str(value), color=c)
                if dpg.does_item_exist("header_font"):
                    dpg.bind_item_font(dpg.last_item(), "header_font")
            if subtitle:
                with dpg.group(horizontal=True):
                    dpg.add_spacer(width=max((cw - 250) // 2, 5))
                    dpg.add_text(subtitle, color=(100, 100, 110))

    def _render_status_badge(self, status):
        colors = {
            "Won": (70, 190, 90),
            "Lost": (200, 60, 60),
            "Pending": (210, 160, 50),
            "Finished": (200, 200, 210),
            "Scheduled": (160, 160, 170),
            "Active": (70, 190, 90),
            "Blocked": (200, 60, 60),
            "Inactive": (160, 160, 170),
            "Deleted": (100, 100, 110),
        }
        c = colors.get(status, (160, 160, 170))
        with dpg.group(horizontal=True):
            dpg.add_text("●", color=c)
            dpg.add_text(status, color=c)

    def _render_pie_chart(self, values, labels, title="", colors=None,
                          height=220, width=400):
        if not values or sum(values) == 0:
            with dpg.child_window(width=width, height=height,
                                  no_scrollbar=True):
                dpg.add_spacer(height=height//3)
                dpg.add_text("No data", color=(140, 140, 150))
            return
        total = sum(values)
        pct_vals = [v / total * 100 for v in values]
        plot_label = title if title else ""
        with dpg.plot(label=plot_label, height=height, width=width,
                      no_title=not title):
            dpg.add_plot_legend()
            y_axis = dpg.add_plot_axis(dpg.mvYAxis, label="",
                                       no_gridlines=True,
                                       no_tick_marks=True,
                                       no_tick_labels=True)
            dpg.add_pie_series(0.5, 0.5, 0.45, pct_vals, labels,
                               format="%0.1f%%", normalize=False, parent=y_axis)

    def _render_bar_chart(self, labels, y_values, title="", color=None,
                          height=220, width=450):
        if not y_values:
            with dpg.child_window(width=width, height=height,
                                  no_scrollbar=True):
                dpg.add_spacer(height=height//3)
                dpg.add_text("No data", color=(140, 140, 150))
            return
        c = color or (255, 255, 255)
        n = len(y_values)
        x_data = list(range(n))
        with dpg.plot(label=title, height=height, width=width,
                      no_title=not title):
            x_axis = dpg.add_plot_axis(dpg.mvXAxis, label="", no_gridlines=True)
            dpg.set_axis_limits(x_axis, -0.5, n - 0.5)
            dpg.set_axis_ticks(x_axis, tuple((i, str(labels[i])) for i in range(n)))
            y_axis = dpg.add_plot_axis(dpg.mvYAxis, label="Amount ($)")
            dpg.add_bar_series(x_data, y_values, parent=y_axis,
                               weight=0.7)

    def _show_client_recent_bets(self):
        try:
            result = self.repo.get_user_bets(self.client_user_id, limit=10)
        except Exception as e:
            dpg.add_text(f"Error loading bets: {e}",
                         color=(200, 60, 60))
            return

        with dpg.group(horizontal=True):
            self._icon("poker_chip", 24, 24)
            dpg.add_spacer(width=5)
            dpg.add_text("Recent Bets", color=(255, 255, 255))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")

        if not result["rows"]:
            dpg.add_spacer(height=10)
            dpg.add_text("No bets placed yet.",
                         color=(140, 140, 150))
            return

        status_colors = {"Won": (70, 190, 90), "Lost": (200, 60, 60),
                         "Pending": (210, 160, 50)}
        pred_icon = {"Home": "house", "Draw": "handshake", "Away": "travel"}

        for row in result["rows"]:
            bid, prediction, amount, bdate, status, mid, mdate, mstatus, home, away = row
            st_color = status_colors.get(status, (160, 160, 170))
            pi = pred_icon.get(prediction, "poker_chip")

            with dpg.child_window(width=-1, height=58, no_scrollbar=True):
                with dpg.group(horizontal=True):
                    dpg.add_spacer(width=8)
                    dpg.add_text(f"{home} vs {away}", color=(190, 190, 200))
                    dpg.add_spacer(width=40)
                    dpg.add_text(f"${float(amount):.2f}", color=(210, 210, 220))
                    dpg.add_spacer(width=30)
                    if self.icon_textures.get(pi):
                        self._icon(pi, 18, 18)
                        dpg.add_spacer(width=4)
                    dpg.add_text(f"{prediction}", color=(255, 255, 255))
                    dpg.add_spacer(width=30)
                    dpg.add_text(f"● {status}", color=st_color)
                    dpg.add_spacer(width=30)
                    dpg.add_text(f"{str(bdate)[:10]}", color=(100, 100, 110))

    # ── CLIENT: MY BETS ───────────────────────────────────────────────────

    def _show_client_bets(self):
        self.current_screen = "client_bets"
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Dashboard",
                           self._show_client_dashboard,
                           f"My Bets — {self.client_user_name}",
                           extra_buttons=[
                               {"label": "Refresh",
                                "callback": self._show_client_bets},
                           ],
                           icon="poker_chip")

        with dpg.group(parent="main_window"):
            dpg.add_spacer(height=10)
            result = self.repo.get_user_bets(self.client_user_id)
            if not result["rows"]:
                dpg.add_text("No bets found.", color=(140, 140, 150))
                dpg.add_text("Place a bet on available matches to get started!",
                             color=(100, 100, 110))
                return

            status_colors = {"Won": (70, 190, 90), "Lost": (200, 60, 60),
                             "Pending": (210, 160, 50)}
            pred_icon = {"Home": "house", "Draw": "handshake", "Away": "travel"}

            for row in result["rows"]:
                bid, prediction, amount, bdate, status, mid, mdate, mstatus, home, away = row
                st_color = status_colors.get(status, (160, 160, 170))
                pi = pred_icon.get(prediction, "poker_chip")

                with dpg.child_window(width=-1, height=72, no_scrollbar=True):
                    with dpg.group(horizontal=True):
                        dpg.add_text(f"  {home}  vs  {away}", color=(200, 200, 210))
                        dpg.add_spacer(width=20)
                        if self.icon_textures.get(pi):
                            self._icon(pi, 22, 22)
                            dpg.add_spacer(width=5)
                        dpg.add_text(f"{prediction}", color=(255, 255, 255))
                        dpg.add_spacer(width=20)
                        dpg.add_text(f"${float(amount):.2f}", color=(210, 210, 220))
                        dpg.add_spacer(width=20)
                        dpg.add_text(f"● {status}", color=st_color)
                        dpg.add_spacer(width=20)
                        dpg.add_text(str(bdate)[:10], color=(120, 120, 130))

    # ── CLIENT: MATCHES & PLACE BET ───────────────────────────────────────

    def _show_client_matches(self):
        self.current_screen = "client_matches"
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Dashboard",
                           self._show_client_dashboard,
                           f"Available Matches — {self.client_user_name}",
                           extra_buttons=[
                               {"label": "Refresh",
                                "callback": self._show_client_matches},
                           ],
                           icon="sports_soccer")

        with dpg.group(parent="main_window"):
            result = self.repo.get_available_matches_with_odds()
            if not result["rows"]:
                dpg.add_text("No available matches with odds.",
                             color=(140, 140, 150))
                return

            for row in result["rows"]:
                mid, mdate, stage, home, away, hodd, dodd, aodd = row
                avg_odds = (float(hodd or 1) + float(dodd or 1) + float(aodd or 1)) / 3

                with dpg.child_window(width=-1, height=290):
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=10)
                        self._icon("sports_soccer", 32, 32)
                        dpg.add_spacer(width=8)
                        dpg.add_text(f"  {home}", color=(220, 220, 230))
                        if dpg.does_item_exist("header_font"):
                            dpg.bind_item_font(dpg.last_item(), "header_font")
                        dpg.add_text("  vs  ", color=(140, 140, 150))
                        dpg.add_text(f"{away}  ", color=(220, 220, 230))
                        if dpg.does_item_exist("header_font"):
                            dpg.bind_item_font(dpg.last_item(), "header_font")

                    dpg.add_spacer(height=4)
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=74)
                        dpg.add_text(f"Date: {str(mdate)[:10]}", color=(140, 140, 150))
                        dpg.add_spacer(width=20)
                        if stage:
                            dpg.add_text(f"Stage: {stage}", color=(140, 140, 150))
                        dpg.add_spacer(width=20)
                        dpg.add_text(f"Avg Odds: {avg_odds:.2f}", color=(100, 100, 110))

                    dpg.add_spacer(height=10)
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=74)
                        if self.icon_textures.get("house"):
                            self._icon("house", 20, 20)
                        dpg.add_button(label=f"  Home  {hodd or '-'}  ",
                                       width=150, height=40,
                                       callback=self._place_bet_from_card,
                                       user_data=(mid, "Home"))
                        dpg.add_spacer(width=5)
                        if self.icon_textures.get("handshake"):
                            self._icon("handshake", 20, 20)
                        dpg.add_button(label=f"  Draw  {dodd or '-'}  ",
                                       width=150, height=40,
                                       callback=self._place_bet_from_card,
                                       user_data=(mid, "Draw"))
                        dpg.add_spacer(width=5)
                        if self.icon_textures.get("travel"):
                            self._icon("travel", 20, 20)
                        dpg.add_button(label=f"  Away  {aodd or '-'}  ",
                                       width=150, height=40,
                                       callback=self._place_bet_from_card,
                                       user_data=(mid, "Away"))

                    bet_form_tag = f"bet_form_{mid}"
                    if dpg.does_item_exist(bet_form_tag):
                        dpg.delete_item(bet_form_tag)
                    with dpg.group(tag=bet_form_tag, horizontal=True):
                        dpg.add_spacer(width=74)
                        dpg.add_input_text(tag=f"bet_amt_{mid}",
                                           label="Amount ($)",
                                           width=200,
                                           default_value="10.00")
                        dpg.add_spacer(width=8)

                    dpg.add_spacer(height=4)
                    msg_tag = f"bet_msg_{mid}"
                    if dpg.does_item_exist(msg_tag):
                        dpg.delete_item(msg_tag)
                    with dpg.child_window(tag=msg_tag, width=-1, height=50,
                                          no_scrollbar=True):
                        dpg.add_text("")
            dpg.add_spacer(height=20)

    def _place_bet_from_card(self, sender, app_data, user_data):
        match_id, prediction = user_data
        amt_tag = f"bet_amt_{match_id}"
        msg_tag = f"bet_msg_{match_id}"

        if not dpg.does_item_exist(msg_tag):
            return

        self._delete_all_children(msg_tag)

        try:
            amount = float(dpg.get_value(amt_tag))
            if amount <= 0:
                raise ValueError
        except ValueError:
            dpg.add_text("Enter a valid positive amount.",
                         color=(200, 60, 60), parent=msg_tag)
            return

        try:
            result = self.repo.place_bet(
                self.client_user_id, match_id, prediction, amount
            )
            dpg.add_text(f"Bet placed! {result['message']}",
                         color=(70, 190, 90), parent=msg_tag)
            dpg.add_text(f"  {prediction} on match #{match_id} — ${amount:.2f}",
                         color=(140, 140, 150), parent=msg_tag)
        except Exception as e:
            dpg.add_text(f"Bet failed: {e}",
                         color=(200, 60, 60), parent=msg_tag)

    # ── CLIENT: TRANSACTIONS ──────────────────────────────────────────────

    def _show_client_transactions(self):
        self.current_screen = "client_transactions"
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Dashboard",
                           self._show_client_dashboard,
                           f"Transactions — {self.client_user_name}",
                           extra_buttons=[
                               {"label": "Refresh",
                                "callback": self._show_client_transactions},
                           ],
                           icon="money_bag")

        with dpg.group(parent="main_window"):
            result = self.repo.get_user_transactions(self.client_user_id)
            if not result["rows"]:
                dpg.add_text("No transactions found.", color=(140, 140, 150))
                return

            txn_icon_map = {"Deposit": "savings", "Withdrawal": "wallet",
                            "Winnings": "trophy", "Bet Placement": "poker_chip"}

            for row in result["rows"]:
                tid, amount, ttype, tdate = row
                amt = float(amount)
                icon_name = txn_icon_map.get(ttype, "money_bag")
                amt_color = (70, 190, 90) if amt > 0 else (200, 60, 60)
                sign = "+" if amt > 0 else ""

                with dpg.child_window(width=-1, height=58, no_scrollbar=True):
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=15)
                        if self.icon_textures.get(icon_name):
                            self._icon(icon_name, 22, 22)
                            dpg.add_spacer(width=8)
                        dpg.add_text(f"{ttype}", color=(200, 200, 210))
                        dpg.add_spacer(width=60)
                        dpg.add_text(f"{sign}${amt:,.2f}", color=amt_color)
                        dpg.add_spacer(width=60)
                        dpg.add_text(f"{str(tdate)[:10]}", color=(120, 120, 130))

    # ── CLIENT: DEPOSIT ──────────────────────────────────────────────────

    def _show_client_deposit(self):
        self.current_screen = "client_deposit"
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Dashboard",
                           self._refresh_client_dashboard,
                           f"Deposit — {self.client_user_name}",
                           icon="savings")

        with dpg.group(parent="main_window"):
            dpg.add_spacer(height=60)

            with dpg.group(horizontal=True):
                dpg.add_spacer(width=350)
                with dpg.child_window(width=500, height=300, no_scrollbar=True):
                    dpg.add_spacer(height=40)
                    with dpg.group(horizontal=True):
                        self._icon("savings", 28, 28)
                        dpg.add_spacer(width=6)
                        dpg.add_text("Deposit Funds", color=(255, 255, 255))
                        if dpg.does_item_exist("header_font"):
                            dpg.bind_item_font(dpg.last_item(), "header_font")
                    dpg.add_spacer(height=20)
                    dpg.add_input_text(tag="deposit_amount",
                                       label="Amount ($)",
                                       width=400,
                                       default_value="100.00")
                    dpg.add_spacer(height=20)
                    dpg.add_button(label="Confirm Deposit",
                                   width=400, height=50,
                                   callback=self._client_deposit)

            with dpg.child_window(tag="deposit_message",
                                  width=-1, height=100):
                dpg.add_text("Enter an amount and click Confirm Deposit.",
                             color=(140, 140, 150))

    def _client_deposit(self):
        tag = "deposit_message"
        if not dpg.does_item_exist(tag):
            return
        self._delete_all_children(tag)
        try:
            amount = float(dpg.get_value("deposit_amount"))
        except ValueError:
            dpg.add_text("Enter a valid numeric amount.",
                         color=(200, 60, 60), parent=tag)
            return
        try:
            result = self.repo.create_deposit(
                self.client_user_id, amount
            )
            dpg.add_text(result["message"], color=(70, 190, 90),
                         parent=tag)
        except Exception as e:
            dpg.add_text(f"Deposit failed: {e}",
                         color=(200, 60, 60), parent=tag)

    # ── CLIENT: WITHDRAW ─────────────────────────────────────────────────

    def _show_client_withdraw(self):
        self.current_screen = "client_withdraw"
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Dashboard",
                           self._refresh_client_dashboard,
                           f"Withdraw — {self.client_user_name}",
                           icon="wallet")

        with dpg.group(parent="main_window"):
            dpg.add_spacer(height=60)

            profile = self.repo.get_user_profile(self.client_user_id)
            bal = float(profile["balance"]) if profile and profile["balance"] else 0

            with dpg.group(horizontal=True):
                dpg.add_spacer(width=350)
                with dpg.child_window(width=500, height=350, no_scrollbar=True):
                    dpg.add_spacer(height=30)
                    with dpg.group(horizontal=True):
                        self._icon("wallet", 28, 28)
                        dpg.add_spacer(width=6)
                        dpg.add_text("Withdraw Funds", color=(255, 255, 255))
                        if dpg.does_item_exist("header_font"):
                            dpg.bind_item_font(dpg.last_item(), "header_font")
                    dpg.add_spacer(height=10)
                    dpg.add_text(f"Available Balance: ${bal:,.2f}",
                                 color=(160, 160, 170))
                    dpg.add_spacer(height=15)
                    dpg.add_input_text(tag="withdraw_amount",
                                       label="Amount ($)",
                                       width=400,
                                       default_value="50.00")
                    dpg.add_spacer(height=20)
                    dpg.add_button(label="Confirm Withdrawal",
                                   width=400, height=50,
                                   callback=self._client_withdraw)

            with dpg.child_window(tag="withdraw_message",
                                  width=-1, height=100):
                dpg.add_text("Enter an amount and click Confirm Withdrawal.",
                             color=(140, 140, 150))

    def _client_withdraw(self):
        tag = "withdraw_message"
        if not dpg.does_item_exist(tag):
            return
        self._delete_all_children(tag)
        try:
            amount = float(dpg.get_value("withdraw_amount"))
        except ValueError:
            dpg.add_text("Enter a valid numeric amount.",
                         color=(200, 60, 60), parent=tag)
            return
        try:
            result = self.repo.create_withdrawal(
                self.client_user_id, amount
            )
            dpg.add_text(result["message"], color=(70, 190, 90),
                         parent=tag)
        except Exception as e:
            dpg.add_text(f"Withdrawal failed: {e}",
                         color=(200, 60, 60), parent=tag)

    # ══════════════════════════════════════════════════════════════════════
    # ADMIN MODE — all existing functionality preserved
    # ══════════════════════════════════════════════════════════════════════

    def _show_admin_home(self):
        self.current_screen = "admin_home"
        self._delete_all_children("main_window")

        dpg.add_spacer(parent="main_window", height=15)

        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=15)
            self._icon("sports_soccer", 40, 40)
            dpg.add_spacer(width=8)
            with dpg.group():
                dpg.add_text("BetMaster Admin", parent="main_window",
                             color=(255, 255, 255))
                if dpg.does_item_exist("header_font"):
                    dpg.bind_item_font(dpg.last_item(), "header_font")

        dpg.add_text("System Administration Dashboard",
                     parent="main_window", color=(140, 140, 150))

        status = "Connected" if self.repo.db.is_connected() else "Disconnected"
        sc = (70, 190, 90) if self.repo.db.is_connected() else (200, 60, 60)
        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_button(label="← Enter as Client",
                           callback=self._show_welcome)
            dpg.add_spacer(width=20)
            dpg.add_text(f"Database: {status}", color=sc)

        dpg.add_spacer(parent="main_window", height=12)

        # ── Admin stats row ──
        astats = self.repo.get_admin_stats()
        if astats:
            with dpg.group(parent="main_window", horizontal=True):
                dpg.add_spacer(width=15)
                self._render_stat_card("Total Users",
                                       f"{astats['total_users']:,}",
                                       color=(220, 180, 30), icon="leaderboard")
                dpg.add_spacer(width=15)
                self._render_stat_card("Total Bets",
                                       f"{astats['total_bets']:,}",
                                       color=(70, 190, 90), icon="poker_chip")
                dpg.add_spacer(width=15)
                self._render_stat_card("Matches",
                                       f"{astats['total_matches']:,}",
                                       color=(210, 160, 50), icon="sports_soccer")
                dpg.add_spacer(width=15)
                inflow = float(astats['total_inflow'])
                outflow = float(astats['total_outflow'])
                net = inflow - outflow
                self._render_stat_card("Net Volume",
                                       f"${net:,.0f}",
                                       color=(200, 120, 60),
                                       subtitle=f"In ${inflow:,.0f} / Out ${outflow:,.0f}",
                                       icon="money_bag")

        dpg.add_spacer(parent="main_window", height=15)

        # ── Action cards row ──
        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=5)
            self._make_card("Data Explorer", 500,
                            self._show_data_screen,
                            "Browse, search, and manage records\n"
                            "across all database tables with\n"
                            "inline editing and pagination.",
                            icon="house")
            dpg.add_spacer(width=5)
            self._make_card("Analytics", 500,
                            self._show_analytics_screen,
                            "Run trend analysis, detect\n"
                            "anomalous betting patterns, and\n"
                            "explore regional insights.",
                            icon="savings")
            dpg.add_spacer(width=5)
            self._make_card("Quick Actions", 500,
                            self._show_quick_actions_screen,
                            "Settle matches, assess user risk,\n"
                            "recalculate account statuses, and\n"
                            "review match financial exposure.",
                            icon="money_bag")

        dpg.add_spacer(parent="main_window", height=15)

        # ── Charts row ──
        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=15)
            # Volume bar chart
            vol_data = self.repo.get_admin_volume_chart()
            vol_labels = [f"{r[1]}/{str(r[0])[2:]}" for r in vol_data] if vol_data else []
            vol_deposits = [float(r[2]) for r in vol_data] if vol_data else []
            vol_withdrawals = [float(r[3]) for r in vol_data] if vol_data else []
            with dpg.child_window(width=960, height=320, no_scrollbar=True):
                with dpg.group(horizontal=True):
                    self._icon("money_bag", 24, 24)
                    dpg.add_spacer(width=5)
                    dpg.add_text("Monthly Transaction Volume", color=(255, 255, 255))
                if vol_labels:
                    with dpg.plot(label="Volume", height=240, width=920):
                        dpg.add_plot_legend()
                        x_axis = dpg.add_plot_axis(dpg.mvXAxis, label="",
                                                   no_gridlines=True)
                        n = len(vol_labels)
                        dpg.set_axis_limits(x_axis, -0.5, n - 0.5)
                        dpg.set_axis_ticks(x_axis,
                                           tuple((i, vol_labels[i]) for i in range(n)))
                        y_axis = dpg.add_plot_axis(dpg.mvYAxis, label="$")
                        dpg.add_bar_series(list(range(n)), vol_deposits,
                                           parent=y_axis, weight=0.4,
                                           label="Deposits")
                        dpg.add_bar_series(list(range(n)), vol_withdrawals,
                                           parent=y_axis, weight=0.4,
                                           label="Withdrawals")
                else:
                    dpg.add_spacer(height=80)
                    dpg.add_text("No transaction data available",
                                 color=(140, 140, 150))

            dpg.add_spacer(width=20)
            # User status pie chart
            status_dist = self.repo.get_user_status_distribution()
            status_labels = [r[0] for r in status_dist] if status_dist else []
            status_vals = [float(r[1]) for r in status_dist] if status_dist else []
            with dpg.child_window(width=500, height=320, no_scrollbar=True):
                with dpg.group(horizontal=True):
                    self._icon("leaderboard", 24, 24)
                    dpg.add_spacer(width=5)
                    dpg.add_text("User Account Status", color=(255, 255, 255))
                status_colors = {"Active": (70, 190, 90, 200),
                                 "Inactive": (160, 160, 170, 200),
                                 "Blocked": (200, 60, 60, 200)}
                pie_colors = [status_colors.get(l, (220, 180, 30)) for l in status_labels]
                self._render_pie_chart(status_vals, status_labels,
                                       height=220, width=450)
                if status_dist:
                    dpg.add_spacer(height=4)
                    info = "  |  ".join(f"{r[0]}: {r[1]}" for r in status_dist)
                    dpg.add_text(info, color=(140, 140, 150), wrap=460)

    def _show_data_screen(self):
        self.current_screen = "admin_data"
        self.current_table = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Admin Home", self._show_admin_home,
                           "Data Management", icon="shoe_cleats")

        with dpg.group(parent="main_window", horizontal=True):
            self._make_data_sidebar()
            with dpg.child_window(tag="data_content", width=-1, height=-1):
                dpg.add_text("Select a table from the sidebar",
                             color=(140, 140, 150))

    def _make_data_sidebar(self):
        with dpg.child_window(tag="data_sidebar", width=SIDEBAR_WIDTH,
                              height=-1):
            dpg.add_text("Tables", color=(140, 140, 150))
            dpg.add_separator()
            dpg.add_spacer(height=5)

            for group_name, table_list in self.TABLE_GROUPS.items():
                with dpg.collapsing_header(label=group_name,
                                           default_open=False):
                    for tbl in table_list:
                        meta = self.repo.get_table_meta(tbl)
                        dpg.add_button(
                            label=meta["display_name"],
                            callback=self._nav_table_callback,
                            tag=f"nav_{tbl}",
                            user_data=tbl,
                        )

    def _nav_table_callback(self, sender, app_data, user_data):
        self.search_term = ""
        self.search_cols = None
        self.all_rows = []
        self.table_offset = 0
        if dpg.does_item_exist("search_input"):
            dpg.set_value("search_input", "")
        self._show_table(user_data)

    def _show_table(self, table_name):
        self.current_table = table_name
        self.table_offset = 0

        content_tag = "data_content"
        self._delete_all_children(content_tag)

        meta = self.repo.get_table_meta(table_name)

        with dpg.group(parent=content_tag, horizontal=True):
            dpg.add_text(meta["display_name"], color=(255, 255, 255))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")
            dpg.add_spacer(width=15)
            dpg.add_button(label="Refresh",
                           callback=lambda: self._refresh_table())
            dpg.add_button(label="+ Create",
                           callback=lambda: self._toggle_create_form())
            dpg.add_spacer(width=30)
            dpg.add_input_text(tag="search_input", hint="Search...",
                               width=250)
            if self.search_term:
                dpg.set_value("search_input", self.search_term)
            dpg.add_button(label="Search", callback=self._do_search)

        dpg.add_separator(parent=content_tag)

        dpg.add_child_window(tag="table_container", parent=content_tag,
                             width=-1, height=-350)
        self._populate_table()

        with dpg.group(parent=content_tag):
            dpg.add_separator()
            with dpg.tab_bar():
                with dpg.tab(label="Update"):
                    with dpg.group(horizontal=True):
                        dpg.add_text("PK: ")
                        for i, pk_col in enumerate(meta["pk"]):
                            dpg.add_input_text(tag=f"upk_{i}", width=100,
                                               hint=str(pk_col))
                        dpg.add_button(label="Fetch",
                                       callback=self._fetch_for_update,
                                       user_data=content_tag)
                        dpg.add_button(label="Clear",
                                       callback=lambda:
                                           self._clear_update_form())
                    dpg.add_group(tag="update_fields")

                with dpg.tab(label="Delete"):
                    with dpg.group(horizontal=True):
                        dpg.add_text("PK: ")
                        for i, pk_col in enumerate(meta["pk"]):
                            dpg.add_input_text(tag=f"dpk_{i}", width=100,
                                               hint=str(pk_col))
                        dpg.add_button(label="Delete",
                                       callback=lambda:
                                           self._delete_row())

    def _do_search(self):
        if not dpg.does_item_exist("search_input"):
            return
        term = dpg.get_value("search_input")
        self.search_term = term.strip()
        if not self.search_term:
            self.search_term = ""
        self._refresh_table()

    def _populate_table(self):
        self._delete_all_children("table_container")
        try:
            if self.search_term:
                result = self.repo._execute_select(
                    self.current_table, self.repo.MAX_ROWS, 0,
                    search=self.search_term, search_cols=self.search_cols)
            else:
                result = self.repo.fetch_all(self.current_table)
        except Exception as e:
            msg = str(e)
            if 'does not exist' in msg:
                dpg.add_text(
                    f"Table '{self.current_table}' not found in database.",
                    parent="table_container", color=(200, 60, 60))
                dpg.add_text(
                    "Run the relevant SQL setup file to create it.",
                    parent="table_container", color=(140, 140, 150))
            else:
                dpg.add_text(f"Error: {msg}", color=(255, 0, 0),
                             parent="table_container")
            return

        self.all_rows = result["rows"]
        self.table_offset = result["limit"]

        if result.get("has_more"):
            dpg.add_text(
                f"Showing first {len(result['rows'])} rows "
                f"(more data available)",
                parent="table_container", color=(210, 160, 50))

        if not result["rows"]:
            dpg.add_text("No data found.", parent="table_container",
                         color=(140, 140, 150))
            return

        self._render_table_data(result["columns"], result["rows"])

        if result.get("has_more"):
            dpg.add_spacer(parent="table_container", height=8)
            dpg.add_button(label="Load More...", parent="table_container",
                           width=200, callback=self._load_more)

    def _render_table_data(self, columns, rows):
        if dpg.does_item_exist("data_grid"):
            dpg.delete_item("data_grid")
        if not rows:
            return
        with dpg.table(parent="table_container", tag="data_grid",
                       header_row=True,
                       borders_innerH=True, borders_outerH=True,
                       borders_innerV=True, borders_outerV=True,
                       row_background=True, resizable=True,
                       policy=dpg.mvTable_SizingStretchSame):
            for col_name in columns:
                dpg.add_table_column(label=col_name)
            for row in rows:
                with dpg.table_row():
                    for cell in row:
                        dpg.add_text(str(cell) if cell is not None else "—")

    def _load_more(self):
        try:
            result = self.repo._execute_select(
                self.current_table, self.repo.MAX_ROWS, self.table_offset,
                search=self.search_term if self.search_term else None,
                search_cols=self.search_cols)
        except Exception as e:
            dpg.add_text(f"Error: {e}", color=(255, 0, 0),
                         parent="table_container")
            return

        if not result["rows"]:
            return

        self.all_rows.extend(result["rows"])
        self.table_offset += result["limit"]

        for child in dpg.get_item_children("table_container", slot=1):
            dpg.delete_item(child)

        dpg.add_text(
            f"Showing {len(self.all_rows)} rows" +
            (" (more data available)" if result.get("has_more") else ""),
            parent="table_container", color=(210, 160, 50))

        self._render_table_data(result["columns"], self.all_rows)

        if result.get("has_more"):
            dpg.add_spacer(parent="table_container", height=8)
            dpg.add_button(label="Load More...", parent="table_container",
                           width=200, callback=self._load_more)

    def _refresh_table(self):
        self._show_table(self.current_table)

    def _toggle_create_form(self):
        meta = self.repo.get_table_meta(self.current_table)
        tag = "create_form"
        if dpg.does_item_exist(tag):
            dpg.delete_item(tag)
            return

        with dpg.group(tag=tag, parent="data_content"):
            dpg.add_separator()
            with dpg.group(horizontal=True):
                self._icon("shoe_cleats", 24, 24)
                dpg.add_spacer(width=5)
                dpg.add_text("Create New Record", color=(70, 190, 90))

            for col in meta["columns"]:
                if col.get("is_pk") and col.get("type") == "BIGINT":
                    continue
                cname = col["name"]
                if col.get("is_fk"):
                    options = self.repo.get_fk_options(
                        self.current_table, cname)
                    items = [str(o[1]) for o in options]
                    dpg.add_combo(tag=f"c_{cname}", label=col["display"],
                                  items=items, width=300,
                                  user_data=options)
                else:
                    dpg.add_input_text(tag=f"c_{cname}",
                                       label=col["display"], width=300)

            dpg.add_button(label="Save",
                           callback=lambda: self._create_row())

    def _create_row(self):
        meta = self.repo.get_table_meta(self.current_table)
        data = {}
        pk_cols = set(meta["pk"])

        for col in meta["columns"]:
            cname = col["name"]
            if col.get("is_pk") and col.get("type") == "BIGINT":
                continue
            tag = f"c_{cname}"
            if not dpg.does_item_exist(tag):
                continue
            val = dpg.get_value(tag)
            if val is None or val == "":
                if cname in pk_cols:
                    continue
                data[cname] = None
                continue
            if col.get("is_fk"):
                options = dpg.get_item_user_data(tag)
                data[cname] = self._fk_display_to_id(options, val)
            elif col["type"] == "INTEGER":
                try:
                    data[cname] = int(val)
                except ValueError:
                    data[cname] = val
            elif col["type"] == "NUMERIC":
                try:
                    data[cname] = float(val)
                except ValueError:
                    data[cname] = val
            else:
                data[cname] = val

        try:
            self.repo.insert(self.current_table, data)
            self._show_table(self.current_table)
        except Exception as e:
            dpg.add_text(f"Create failed: {e}", color=(255, 0, 0),
                         parent="data_content")

    def _fetch_for_update(self, sender, app_data, user_data):
        meta = self.repo.get_table_meta(self.current_table)
        pk_values = []
        for i in range(len(meta["pk"])):
            tag = f"upk_{i}"
            if dpg.does_item_exist(tag):
                val = dpg.get_value(tag)
                if not val:
                    dpg.add_text("Enter PK first", color=(200, 60, 60),
                                 parent="data_content")
                    return
                pk_values.append(val)

        try:
            row = self.repo.fetch_by_pk(self.current_table, pk_values)
        except Exception as e:
            dpg.add_text(f"Fetch failed: {e}", color=(200, 60, 60),
                         parent="data_content")
            return

        if not row:
            dpg.add_text("Row not found", color=(200, 60, 60),
                         parent="data_content")
            return

        tg = "update_fields"
        self._delete_all_children(tg)

        dpg.add_text("Edit fields and save", parent=tg,
                     color=(210, 160, 50))
        dpg.add_separator(parent=tg)

        for col in meta["columns"]:
            cname = col["name"]
            cur_val = row.get(cname, "") or ""
            if col.get("is_fk"):
                options = self.repo.get_fk_options(
                    self.current_table, cname)
                items = [str(o[1]) for o in options]
                cur_display = self._fk_id_to_display(options, cur_val)
                dpg.add_combo(tag=f"u_{cname}", label=col["display"],
                              items=items, default_value=cur_display,
                              width=300, parent=tg, user_data=options)
            else:
                dpg.add_input_text(tag=f"u_{cname}",
                                   label=col["display"],
                                   default_value=str(cur_val),
                                   width=300, parent=tg)

        dpg.add_button(label="Save Update", parent=tg,
                       callback=lambda: self._update_row(pk_values))

    def _clear_update_form(self):
        self._delete_all_children("update_fields")

    def _update_row(self, pk_values):
        meta = self.repo.get_table_meta(self.current_table)
        data = {}
        for col in meta["columns"]:
            cname = col["name"]
            if cname in meta["pk"]:
                continue
            tag = f"u_{cname}"
            if not dpg.does_item_exist(tag):
                continue
            val = dpg.get_value(tag)
            if val is None or val == "":
                data[cname] = None
                continue
            if col.get("is_fk"):
                options = dpg.get_item_user_data(tag)
                data[cname] = self._fk_display_to_id(options, val)
            elif col["type"] == "INTEGER":
                try:
                    data[cname] = int(val)
                except ValueError:
                    data[cname] = val
            elif col["type"] == "NUMERIC":
                try:
                    data[cname] = float(val)
                except ValueError:
                    data[cname] = val
            else:
                data[cname] = val

        try:
            self.repo.update(self.current_table, pk_values, data)
            self._show_table(self.current_table)
        except Exception as e:
            dpg.add_text(f"Update failed: {e}", color=(255, 0, 0),
                         parent="data_content")

    def _delete_row(self):
        meta = self.repo.get_table_meta(self.current_table)
        pk_values = []
        for i in range(len(meta["pk"])):
            tag = f"dpk_{i}"
            if dpg.does_item_exist(tag):
                val = dpg.get_value(tag)
                if not val:
                    dpg.add_text("Enter PK first", color=(200, 60, 60),
                                 parent="data_content")
                    return
                pk_values.append(val)

        try:
            self.repo.delete(self.current_table, pk_values)
            self._show_table(self.current_table)
        except Exception as e:
            dpg.add_text(f"Delete failed: {e}", color=(255, 0, 0),
                         parent="data_content")

    def _fk_display_to_id(self, options, display_val):
        for opt in options:
            if str(opt[1]) == str(display_val):
                return opt[0]
        return display_val

    def _fk_id_to_display(self, options, id_val):
        for opt in options:
            if str(opt[0]) == str(id_val):
                return str(opt[1])
        return str(id_val) if id_val is not None else ""

    def _show_analytics_screen(self):
        self.current_screen = "admin_analytics"
        self.current_table = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Admin Home", self._show_admin_home,
                           "Analytics", icon="savings")

        query_map = {
            "Trends & Insights": {
                "icon": "savings",
                "queries": {
                    "Top Winners": "Top Recent Winners",
                    "Monthly Cash Flow": "Monthly Cash Flow",
                }
            },
            "Anomaly Detection": {
                "icon": "shoe_cleats",
                "queries": {
                    "Suspicious Win Rates": "Suspicious Winning Patterns",
                    "Away Team Upsets": "Away Team Upsets",
                }
            },
            "Regional Analysis": {
                "icon": "travel",
                "queries": {
                    "High-Value Regional Users": "High-Value Regional Users",
                }
            },
        }

        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=15)
            for group_name, group_data in query_map.items():
                with dpg.child_window(width=480, height=260,
                                      no_scrollbar=True):
                    cw = 440
                    dpg.add_spacer(height=14)
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=max((cw - 200) // 2, 5))
                        self._icon(group_data["icon"], 28, 28)
                        dpg.add_spacer(width=8)
                        dpg.add_text(group_name, color=(140, 140, 150))
                    dpg.add_spacer(height=10)
                    for btn_label, query_key in group_data["queries"].items():
                        with dpg.group(horizontal=True):
                            dpg.add_spacer(width=max((cw - 420) // 2, 5))
                            dpg.add_button(
                                label=btn_label, width=420, height=42,
                                callback=self._execute_query,
                                user_data=query_key,
                            )
                        dpg.add_spacer(height=6)
                dpg.add_spacer(width=20)

        dpg.add_spacer(parent="main_window", height=10)
        dpg.add_child_window(tag="q_results", parent="main_window",
                             width=-1, height=-100)
        dpg.add_text("Click a query above to run it", parent="q_results",
                     color=(140, 140, 150))

    def _show_quick_actions_screen(self):
        self.current_screen = "admin_quick_actions"
        self.current_table = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Admin Home", self._show_admin_home,
                           "Quick Actions", icon="money_bag")

        actions = [
            {
                "title": "Settle Match",
                "desc": "Set a match's final result and\nautomatically pay out winning bets.",
                "icon": "trophy",
                "proc_key": "Settle Match (proc_settle_match)",
            },
            {
                "title": "Match Financial Summary",
                "desc": "View financial exposure per match:\nbets, stakes, potential liability.",
                "icon": "money_bag",
                "proc_key": "Match Financial Summary (fn_match_financial_summary)",
            },
            {
                "title": "User Risk Assessment",
                "desc": "Calculate risk scores and flag\nsuspicious accounts for review.",
                "icon": "shoe_cleats",
                "proc_key": "Open User Risk Report (fn_open_user_risk_report)",
            },
            {
                "title": "Recalculate User Statuses",
                "desc": "Re-evaluate account statuses\nbased on risk rules and thresholds.",
                "icon": "leaderboard",
                "proc_key": "Recalculate User Statuses (proc_recalculate_user_statuses)",
            },
        ]

        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_spacer(width=15)
            for i, act in enumerate(actions):
                desc_lines = act["desc"].count('\n') + 1
                desc_h = desc_lines * 42 + 10
                cw = 320
                with dpg.child_window(width=380, height=400):
                    flex_top = 350 - 16 - 36 - 14 - 8 - desc_h - 8 - 44 - 16
                    dpg.add_spacer(height=16)
                    with dpg.group(horizontal=True):
                        dpg.add_text(act["title"], color=(255, 255, 255),
                                     wrap=280)
                        if dpg.does_item_exist("header_font"):
                            dpg.bind_item_font(dpg.last_item(),
                                               "header_font")
                    dpg.add_spacer(height=14)
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=max((cw - 320) // 2, 5))
                        dpg.add_text(act["desc"], color=(160, 160, 170),
                                     wrap=320)
                    dpg.add_spacer(height=max(flex_top, 5))
                    with dpg.group(horizontal=True):
                        dpg.add_spacer(width=max((cw - 320) // 2, 5))
                        dpg.add_button(
                            label="Open →", width=320, height=44,
                            user_data=act["proc_key"],
                            callback=lambda s, a, u: self._show_program_form(u),
                        )

        dpg.add_group(tag="p_form", parent="main_window")
        dpg.add_spacer(parent="main_window", height=5)
        dpg.add_child_window(tag="p_results", parent="main_window",
                             width=-1, height=-100)
        dpg.add_text("Choose an action above", parent="p_results",
                     color=(140, 140, 150))

    def _execute_query(self, sender, app_data, query_name):
        if not query_name:
            return
        self._delete_all_children("q_results")
        try:
            result = self.repo.execute_query(query_name)
        except Exception as e:
            dpg.add_text(f"Error: {e}", color=(255, 0, 0),
                         parent="q_results")
            return
        if not result["rows"]:
            dpg.add_text("No results.", parent="q_results",
                         color=(140, 140, 150))
            return
        with dpg.table(parent="q_results", header_row=True,
                       borders_innerH=True, borders_outerH=True,
                       borders_innerV=True, borders_outerV=True,
                       row_background=True, resizable=True,
                       policy=dpg.mvTable_SizingStretchSame):
            for cn in result["columns"]:
                dpg.add_table_column(label=cn)
            for row in result["rows"]:
                with dpg.table_row():
                    for cell in row:
                        dpg.add_text(str(cell) if cell is not None else "—")

    def _show_program_form(self, prog_name):
        if not prog_name:
            return
        meta_info = self.repo.PROCEDURES[prog_name]
        self._delete_all_children("p_form")
        dpg.add_text(meta_info["description"], parent="p_form",
                     color=(140, 140, 150), wrap=600)
        dpg.add_spacer(parent="p_form", height=5)

        for param in meta_info["params"]:
            pname = param["name"]
            if param.get("options"):
                dpg.add_combo(tag=f"pp_{pname}", label=param["label"],
                              items=param["options"], width=300,
                              default_value=param.get("default", ""),
                              parent="p_form")
            else:
                dpg.add_input_text(tag=f"pp_{pname}",
                                   label=param["label"],
                                   default_value=param.get("default", ""),
                                   width=300, parent="p_form")

        dpg.add_button(label=f"Execute {meta_info['name']}",
                       parent="p_form",
                       callback=lambda: self._execute_program(prog_name))

    def _execute_program(self, prog_name):
        meta_info = self.repo.PROCEDURES[prog_name]
        params = []
        for param in meta_info["params"]:
            tag = f"pp_{param['name']}"
            if dpg.does_item_exist(tag):
                val = dpg.get_value(tag)
                params.append(val if val != "" else None)
            else:
                params.append(None)

        self._delete_all_children("p_results")
        try:
            result = self.repo.execute_procedure(
                meta_info["name"], params)
        except Exception as e:
            dpg.add_text(f"Error: {e}", color=(255, 0, 0),
                         parent="p_results")
            return

        if result.get("message"):
            dpg.add_text(result["message"], color=(70, 190, 90),
                         parent="p_results")

        if result["rows"]:
            with dpg.table(parent="p_results", header_row=True,
                           borders_innerH=True, borders_outerH=True,
                           borders_innerV=True, borders_outerV=True,
                           row_background=True, resizable=True,
                           policy=dpg.mvTable_SizingStretchSame):
                for cn in result["columns"]:
                    dpg.add_table_column(label=cn)
                for row in result["rows"]:
                    with dpg.table_row():
                        for cell in row:
                            dpg.add_text(
                                str(cell) if cell is not None else "—")
        elif not result.get("message"):
            dpg.add_text("Done (no results).", parent="p_results")
