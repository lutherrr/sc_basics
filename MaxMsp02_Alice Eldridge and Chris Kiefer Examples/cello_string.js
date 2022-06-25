// Mgraphics init:
mgraphics.init();
inlets = 1;
outlets = 1;
setinletassist(0, 'Ctrl In');
setoutletassist(0, 'Ctrl Out');

this.string_width = jsarguments[1];

this.string_state = {
    vibration : 0.,
    x_pos : 0.
};

this.box_info = update_box_info(this);

this.style = {
    string_col : [0.812, 0.812, 0.812, 1.000],
    bg_col : [0.569, 0.376, 0.231, 1.000]
};

function set_x_pos(val){
    this.string_state.x_pos = val
    update();
}

function update(){
    mgraphics.redraw();
};

function paint(){
    draw_bg();

    draw_string();
};

function draw_bg(){
    with(mgraphics){
        set_source_rgba(this.style.bg_col);
        rectangle([0, 0, this.box_info[2], this.box_info[3]]);
        fill();
    };
};

function draw_string(){

    with(mgraphics){

        draw_x_pos = (this.string_state.x_pos * (this.box_info[2] * 0.5)) + (this.box_info[2] * 0.5);

        set_source_rgba(this.style.string_col);
        set_line_width(this.string_width);

        move_to(this.box_info[2] * 0.5, -10);

        curve_to(draw_x_pos, this.box_info[3] * 0.3, draw_x_pos, this.box_info[3] * 0.6, this.box_info[2] * 0.5, this.box_info[3] + 10);

        stroke();

    }

}

function update_box_info(obj){
    x = obj.box.rect[0];
    y = obj.box.rect[1];
    w = obj.box.rect[2] - obj.box.rect[0];
    h = obj.box.rect[3] - obj.box.rect[1];

    return [x, y, w, h];
};

function onresize(){
    this.box_info = update_box_info(this);
    update();
}