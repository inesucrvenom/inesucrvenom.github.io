<?php

class Parser{

    const broccoli_picture = '<img src = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/'
            . 'Broccoli_and_cross_section_edit.jpg/320px-Broccoli_and_cross_section_edit.jpg'
            . ' title="Broccoli is yummy!" alt="A lovely picture of broccoli" />';

    /** Replaces markdown link into html link tag.
     *
     * @param string $s Haystack string
     *
     * @return string String with replace done if needed
     *
     * information here:
     * http://stackoverflow.com/questions/24985530/parsing-a-markdown-style-link-safely
     * http://stackoverflow.com/questions/10571326/why-is-my-php-regex-that-parses-markdown-links-broken
     */
     static function doMarkdownLinks($s) {
        return preg_replace_callback('/\[([^]]*)\]\(([^)]*)\)/', function ($matches) {
            return '<a href="' . $matches[2] . '">' . $matches[1] . '</a>'; }, $s);
    }

    /** Parses markdown text from input file and writes result into output file.
     *
     * @param string $file_in_name filename of input file
     * @param string $file_out_name filename of output file
     *
     * @return bool True if successful, false if failed.
     *
     * Note from file_put_contents php doc comments:
     * file_put_contents is advised to be used if only one write is done,
     * for a lot (>100k) consecutive writes, benchmark tests are somewhat better for
     * fopen + fwrite + fclose combination.
     */
    public static function markdownParse($file_in_name, $file_out_name){
        $file_in = file_get_contents($file_in_name);
        $output_data = "";

        // in case of error reading file
        if ($file_in === false){
            return false;
        }

        $rows = explode("\n", $file_in);
        $rows_size = count($rows);
        $p_first_line = true;
        for ($i = 0; $i < $rows_size; $i++){
            $data = $rows[$i];
            if ($i < $rows_size - 1) {
                $data_next = $rows[$i+1];
            }

            // link part
            $data = self::doMarkdownLinks($data);

            // picture part
            $data = str_replace("___EAT___", self::broccoli_picture, $data);

            // headings part
            if (substr($data, 0, 2) == "##"){
                $output_data .= "<h2>" . substr($data, 3) . "</h2>" . PHP_EOL;

            } elseif (substr($data, 0, 1) == "#"){
                $output_data .= "<h1>" . substr($data, 2) . "</h1>" . PHP_EOL;
            }

            // paragraphs and line break
            elseif ($p_first_line == true) {
                    if ($data != "") {
                        $output_data .= "<p>" . $data . PHP_EOL;
                        $p_first_line = false;
                    }
            } elseif ($data_next == "" or ($i == $rows_size - 1)) {
                $output_data .= $data . "</p>" . PHP_EOL . PHP_EOL;
                $p_first_line = true;
            } else {
                if (substr($data, -2) == "  "){
                    $output_data .= rtrim($data) . "</ br>" . PHP_EOL;
                } else {
                    $output_data .= $data . PHP_EOL;
                }

            }
        }

        $file_out = file_put_contents($file_out_name, $output_data);
        return $file_out;
    }
}

// test

Parser::markdownParse('file_in.txt','file_out.txt');
