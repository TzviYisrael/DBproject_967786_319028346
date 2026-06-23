import os
import dearpygui.dearpygui as dpg

SIDEBAR_WIDTH = 200
FONT_PATH = "/usr/share/fonts/abattis-cantarell-fonts/Cantarell-Regular.otf"
FONT_BOLD_PATH = "/usr/share/fonts/abattis-cantarell-fonts/Cantarell-Bold.otf"
FONT_SIZE = 26
HEADER_SIZE = 36


class BetMasterAdmin:
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
        "Integration": ["integration_sources", "integration_team_map", "integration_match_map"],
        "Audit & Risk": ["account_audit_log", "risk_review_queue", "match_settlement_log", "odds_audit_log"],
    }

    def __init__(self, repo):
        self.repo = repo
        self.current_table = None
        self.current_screen = "home"
        self.table_offset = 0
        self.all_rows = []
        self.search_term = ""
        self.search_cols = None

    def run(self):
        dpg.create_context()
        dpg.create_viewport(title="BetMaster Admin UI", width=1600, height=1000)
        self._setup_fonts()
        self._setup_theme()
        self._create_layout()
        dpg.set_primary_window("main_window", True)
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
        bg = (20, 22, 28)
        panel = (28, 30, 38)
        accent = (70, 130, 210)
        accent_hover = (90, 155, 235)
        accent_active = (50, 100, 180)
        text = (220, 220, 225)
        text_dim = (140, 140, 150)
        success = (70, 190, 90)
        warning = (210, 160, 50)
        danger = (200, 60, 60)
        border = (50, 52, 60)

        with dpg.theme() as global_theme:
            with dpg.theme_component(dpg.mvAll):
                dpg.add_theme_color(dpg.mvThemeCol_WindowBg, bg)
                dpg.add_theme_color(dpg.mvThemeCol_ChildBg, panel)
                dpg.add_theme_color(dpg.mvThemeCol_Text, text)
                dpg.add_theme_color(dpg.mvThemeCol_TextDisabled, text_dim)
                dpg.add_theme_color(dpg.mvThemeCol_Border, border)
                dpg.add_theme_color(dpg.mvThemeCol_BorderShadow, (0, 0, 0, 0))
                dpg.add_theme_color(dpg.mvThemeCol_Button, accent)
                dpg.add_theme_color(dpg.mvThemeCol_ButtonHovered, accent_hover)
                dpg.add_theme_color(dpg.mvThemeCol_ButtonActive, accent_active)
                dpg.add_theme_color(dpg.mvThemeCol_Header, (accent[0], accent[1], accent[2], 80))
                dpg.add_theme_color(dpg.mvThemeCol_HeaderHovered, (accent[0], accent[1], accent[2], 120))
                dpg.add_theme_color(dpg.mvThemeCol_FrameBg, (35, 37, 45))
                dpg.add_theme_color(dpg.mvThemeCol_FrameBgHovered, (40, 42, 52))
                dpg.add_theme_color(dpg.mvThemeCol_FrameBgActive, (50, 52, 62))
                dpg.add_theme_color(dpg.mvThemeCol_TitleBg, panel)
                dpg.add_theme_color(dpg.mvThemeCol_TitleBgActive, panel)
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarBg, (25, 27, 35))
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarGrab, (60, 62, 72))
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarGrabHovered, (80, 82, 92))
                dpg.add_theme_color(dpg.mvThemeCol_ScrollbarGrabActive, (100, 102, 112))
                dpg.add_theme_color(dpg.mvThemeCol_TableHeaderBg, (35, 37, 45))
                dpg.add_theme_color(dpg.mvThemeCol_TableRowBg, (28, 30, 38))
                dpg.add_theme_color(dpg.mvThemeCol_TableRowBgAlt, (32, 34, 42))
                dpg.add_theme_color(dpg.mvThemeCol_TableBorderStrong, border)
                dpg.add_theme_color(dpg.mvThemeCol_TableBorderLight, (40, 42, 50))
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

    def _delete_all_children(self, tag):
        for child in dpg.get_item_children(tag, slot=1):
            dpg.delete_item(child)

    def _create_layout(self):
        with dpg.window(tag="main_window", label="BetMaster Admin UI",
                        no_close=True, no_collapse=True):
            self._show_home()

    def _show_home(self):
        self.current_screen = "home"
        self._delete_all_children("main_window")

        dpg.add_spacer(parent="main_window", height=30)

        dpg.add_text("BetMaster Admin", parent="main_window",
                     color=(70, 130, 210))
        if dpg.does_item_exist("header_font"):
            dpg.bind_item_font(dpg.last_item(), "header_font")

        dpg.add_text("Football Betting Management System", parent="main_window",
                     color=(140, 140, 150))

        dpg.add_spacer(parent="main_window", height=30)

        dpg.add_child_window(parent="main_window", tag="cards_row",
                             width=-1, height=440, no_scrollbar=True)

        with dpg.group(parent="cards_row", horizontal=True):
            dpg.add_spacer(width=40)
            self._make_card("Data Management", 460,
                            lambda: self._show_data_screen(),
                            "Browse, create, update and delete\n\nrecords across all 21 database tables.")
            dpg.add_spacer(width=40)
            self._make_card("Analytical Queries", 460,
                            lambda: self._show_queries_screen(),
                            "Run Stage B analytical queries:\ntop winners, suspicious patterns,\nregional analysis and more.")
            dpg.add_spacer(width=40)
            self._make_card("PL/pgSQL Programs", 460,
                            lambda: self._show_programs_screen(),
                            "Execute Stage D programs:\nsettle matches, risk reports,\nstatus recalculations.")

        status = "Connected" if self.repo.db.is_connected() else "Disconnected"
        c = (70, 190, 90) if self.repo.db.is_connected() else (200, 60, 60)
        dpg.add_spacer(parent="main_window", height=20)
        dpg.add_text(f"Database: {status}", parent="main_window", color=c)

    def _make_card(self, title, card_w, callback, desc):
        card_h = 420
        with dpg.child_window(width=card_w, height=card_h,
                              no_scrollbar=True):
            dpg.add_spacer(height=50)
            dpg.add_text(title, color=(70, 130, 210))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")
            dpg.add_spacer(height=35)
            dpg.add_text(desc, color=(160, 160, 170), wrap=card_w - 40)
            dpg.add_spacer(height=40)
            dpg.add_button(label="Open →", width=card_w - 40, height=50,
                           callback=callback)

    def _show_data_screen(self):
        self.current_screen = "data"
        self.current_table = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Home", self._show_home, "Data Management")

        with dpg.group(parent="main_window", horizontal=True):
            self._make_data_sidebar()
            with dpg.child_window(tag="data_content", width=-1, height=-1):
                dpg.add_text("Select a table from the sidebar", color=(140, 140, 150))

    def _make_top_bar(self, back_label, back_callback, title):
        with dpg.group(parent="main_window", horizontal=True):
            dpg.add_button(label=back_label, callback=lambda: back_callback())
            dpg.add_spacer(width=20)
            dpg.add_text(title, color=(70, 130, 210))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")
        dpg.add_separator(parent="main_window")

    def _make_data_sidebar(self):
        with dpg.child_window(tag="data_sidebar", width=SIDEBAR_WIDTH, height=-1):
            dpg.add_text("Tables", color=(140, 140, 150))
            dpg.add_separator()
            dpg.add_spacer(height=5)

            for group_name, table_list in self.TABLE_GROUPS.items():
                with dpg.collapsing_header(label=group_name, default_open=False):
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
            dpg.add_text(meta["display_name"], color=(70, 130, 210))
            if dpg.does_item_exist("header_font"):
                dpg.bind_item_font(dpg.last_item(), "header_font")
            dpg.add_spacer(width=15)
            dpg.add_button(label="Refresh", callback=lambda: self._refresh_table())
            dpg.add_button(label="+ Create", callback=lambda: self._toggle_create_form())
            dpg.add_spacer(width=30)
            dpg.add_input_text(tag="search_input", hint="Search...", width=250)
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
                            dpg.add_input_text(tag=f"upk_{i}", width=100, hint=str(pk_col))
                        dpg.add_button(label="Fetch", callback=self._fetch_for_update, user_data=content_tag)
                        dpg.add_button(label="Clear", callback=lambda: self._clear_update_form())
                    dpg.add_group(tag="update_fields")

                with dpg.tab(label="Delete"):
                    with dpg.group(horizontal=True):
                        dpg.add_text("PK: ")
                        for i, pk_col in enumerate(meta["pk"]):
                            dpg.add_input_text(tag=f"dpk_{i}", width=100, hint=str(pk_col))
                        dpg.add_button(label="Delete", callback=lambda: self._delete_row())

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
                dpg.add_text(f"Table '{self.current_table}' not found in database.",
                             parent="table_container", color=(200, 60, 60))
                dpg.add_text("Run the relevant SQL setup file to create it.",
                             parent="table_container", color=(140, 140, 150))
            else:
                dpg.add_text(f"Error: {msg}", color=(255, 0, 0), parent="table_container")
            return

        self.all_rows = result["rows"]
        self.table_offset = result["limit"]

        if result.get("has_more"):
            dpg.add_text(f"Showing first {len(result['rows'])} rows (more data available)",
                         parent="table_container", color=(210, 160, 50))

        if not result["rows"]:
            dpg.add_text("No data found.", parent="table_container", color=(140, 140, 150))
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
        with dpg.table(parent="table_container", tag="data_grid", header_row=True,
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
            dpg.add_text(f"Error: {e}", color=(255, 0, 0), parent="table_container")
            return

        if not result["rows"]:
            return

        self.all_rows.extend(result["rows"])
        self.table_offset += result["limit"]

        # Remove old table and "Load More" button if any
        for child in dpg.get_item_children("table_container", slot=1):
            dpg.delete_item(child)

        dpg.add_text(f"Showing {len(self.all_rows)} rows" +
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
            dpg.add_text("Create New Record", color=(70, 190, 90))

            for col in meta["columns"]:
                if col.get("is_pk") and col.get("type") == "BIGINT":
                    continue
                cname = col["name"]
                if col.get("is_fk"):
                    options = self.repo.get_fk_options(self.current_table, cname)
                    items = [str(o[1]) for o in options]
                    dpg.add_combo(tag=f"c_{cname}", label=col["display"],
                                  items=items, width=300, user_data=options)
                else:
                    dpg.add_input_text(tag=f"c_{cname}", label=col["display"],
                                       width=300)

            dpg.add_button(label="Save", callback=lambda: self._create_row())

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
            dpg.add_text(f"Create failed: {e}", color=(255, 0, 0), parent="data_content")

    def _fetch_for_update(self, sender, app_data, user_data):
        meta = self.repo.get_table_meta(self.current_table)
        pk_values = []
        for i in range(len(meta["pk"])):
            tag = f"upk_{i}"
            if dpg.does_item_exist(tag):
                val = dpg.get_value(tag)
                if not val:
                    dpg.add_text("Enter PK first", color=(200, 60, 60), parent="data_content")
                    return
                pk_values.append(val)

        try:
            row = self.repo.fetch_by_pk(self.current_table, pk_values)
        except Exception as e:
            dpg.add_text(f"Fetch failed: {e}", color=(200, 60, 60), parent="data_content")
            return

        if not row:
            dpg.add_text("Row not found", color=(200, 60, 60), parent="data_content")
            return

        tg = "update_fields"
        self._delete_all_children(tg)

        dpg.add_text("Edit fields and save", parent=tg, color=(210, 160, 50))
        dpg.add_separator(parent=tg)

        for col in meta["columns"]:
            cname = col["name"]
            cur_val = row.get(cname, "") or ""
            if col.get("is_fk"):
                options = self.repo.get_fk_options(self.current_table, cname)
                items = [str(o[1]) for o in options]
                cur_display = self._fk_id_to_display(options, cur_val)
                dpg.add_combo(tag=f"u_{cname}", label=col["display"],
                              items=items, default_value=cur_display,
                              width=300, parent=tg, user_data=options)
            else:
                dpg.add_input_text(tag=f"u_{cname}", label=col["display"],
                                   default_value=str(cur_val), width=300, parent=tg)

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
            dpg.add_text(f"Update failed: {e}", color=(255, 0, 0), parent="data_content")

    def _delete_row(self):
        meta = self.repo.get_table_meta(self.current_table)
        pk_values = []
        for i in range(len(meta["pk"])):
            tag = f"dpk_{i}"
            if dpg.does_item_exist(tag):
                val = dpg.get_value(tag)
                if not val:
                    dpg.add_text("Enter PK first", color=(200, 60, 60), parent="data_content")
                    return
                pk_values.append(val)

        try:
            self.repo.delete(self.current_table, pk_values)
            self._show_table(self.current_table)
        except Exception as e:
            dpg.add_text(f"Delete failed: {e}", color=(255, 0, 0), parent="data_content")

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

    def _show_queries_screen(self):
        self.current_screen = "queries"
        self.current_table = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Home", self._show_home, "Analytical Queries — Stage B")

        with dpg.group(parent="main_window", tag="queries_panel"):
            dpg.add_spacer(height=5)
            dpg.add_text("Select a query from Stage B to execute:", color=(140, 140, 150))
            query_names = list(self.repo.QUERIES.keys())
            dpg.add_combo(tag="q_selector", label="Query", items=query_names,
                          width=500,
                          callback=lambda s, a: self._execute_query(a))
            dpg.add_child_window(tag="q_results", parent="queries_panel", width=-1, height=-400)
            dpg.add_text("Choose a query above", parent="q_results", color=(140, 140, 150))

    def _show_programs_screen(self):
        self.current_screen = "programs"
        self.current_table = None
        self._delete_all_children("main_window")

        self._make_top_bar("← Back to Home", self._show_home, "PL/pgSQL Programs — Stage D")

        with dpg.group(parent="main_window", tag="programs_panel"):
            dpg.add_spacer(height=5)
            dpg.add_text("Select a Stage D program to execute:", color=(140, 140, 150))
            proc_names = list(self.repo.PROCEDURES.keys())
            dpg.add_combo(tag="p_selector", label="Program", items=proc_names,
                          width=500,
                          callback=lambda s, a: self._show_program_form(a))
            dpg.add_group(tag="p_form", parent="programs_panel")
            dpg.add_child_window(tag="p_results", parent="programs_panel", width=-1, height=-350)
            dpg.add_text("Choose a program above", parent="p_results", color=(140, 140, 150))

    def _execute_query(self, query_name):
        if not query_name:
            return
        self._delete_all_children("q_results")
        try:
            result = self.repo.execute_query(query_name)
        except Exception as e:
            dpg.add_text(f"Error: {e}", color=(255, 0, 0), parent="q_results")
            return
        if not result["rows"]:
            dpg.add_text("No results.", parent="q_results", color=(140, 140, 150))
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
        dpg.add_text(meta_info["description"], parent="p_form", color=(140, 140, 150), wrap=600)
        dpg.add_spacer(parent="p_form", height=5)

        for param in meta_info["params"]:
            pname = param["name"]
            if param.get("options"):
                dpg.add_combo(tag=f"pp_{pname}", label=param["label"],
                              items=param["options"], width=300,
                              default_value=param.get("default", ""), parent="p_form")
            else:
                dpg.add_input_text(tag=f"pp_{pname}", label=param["label"],
                                   default_value=param.get("default", ""),
                                   width=300, parent="p_form")

        dpg.add_button(label=f"Execute {meta_info['name']}", parent="p_form",
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
            result = self.repo.execute_procedure(meta_info["name"], params)
        except Exception as e:
            dpg.add_text(f"Error: {e}", color=(255, 0, 0), parent="p_results")
            return

        if result.get("message"):
            dpg.add_text(result["message"], color=(70, 190, 90), parent="p_results")

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
                            dpg.add_text(str(cell) if cell is not None else "—")
        elif not result.get("message"):
            dpg.add_text("Done (no results).", parent="p_results")
