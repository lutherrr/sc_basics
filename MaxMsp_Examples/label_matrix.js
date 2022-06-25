inlets = 1;
outlets = 1;
setinletassist(0, 'Ctrl In');
setoutletassist(0, 'Ctrl Out');

this.dict_name = jsarguments[1];
this.matrix = {};

function add_count(key){
    current_count = this.matrix[key]['count'];
    current_count = current_count + 1;
    this.matrix[key]['count'] = current_count;
}

function clear_matrix(){
    for(items in this.matrix){
        this.matrix[items]['count'] = 0;
    };
};

function set_matrix(){
    this.matrix = {};
    var dict_obj = new Dict(this.dict_name);
    label_array = dict_obj.get('labels');

    if(label_array == null){
        label_array = [];
    }
    else if(Array.isArray(label_array) == false){
        label_array = [label_array];
    };

    for(i = 0; i < label_array.length; i++){
        this_entry = {}
        this_entry['count'] = 0;
        this_entry['name'] = label_array[i];
        this.matrix[label_array[i]] = this_entry;
    };

    outlet(0, 'bang');
};

function print_matrix(){

    for(items in this.matrix){
        post(String(items) + ': ' + String(this.matrix[items]['count']) + '.\n');
    }

    post('\n');

}