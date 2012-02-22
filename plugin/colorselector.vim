if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

function! ColorSelector()
python << EOF

import vim
import gtk


class ColorChooser:
    def delete_event(self, widget, event, data=None):
        gtk.main_quit()
        return False

    # press Escape to Cancel
    def key_event(self, widget, event, data=None):
        if event.type == gtk.gdk.KEY_PRESS:
            if gtk.gdk.keyval_name(event.keyval) == 'Escape':
                gtk.main_quit()
                return False

    #def color_changed_event(self, data=None):
    #    data.set_previous_color(data.get_current_color())

    def __init__(self, raw_color=None):
        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        self.window.set_title("Color")
        self.window.set_resizable(False)
        self.window.set_position(1)
        self.window.connect("delete_event", self.delete_event)
        self.window.connect("key_press_event", self.key_event)
        self.window.set_border_width(2)

        self.colorselection = gtk.ColorSelection()
        self.colorselection.set_has_palette(True)
        if raw_color:
            self.colorselection.set_current_color(self.raw_color)
        #self.colorselection.connect("color-changed", self.color_changed_event)
        self.window.add(self.colorselection)

        self.window.show_all()

raw_color = vim.eval("v:beval_text")
print '>>', raw_color
if raw_color and raw_color.startswitch('#'):
    c = ColorChooser(raw_color)
else:
    c = ColorChooser()
gtk.main()

EOF
endfunction
