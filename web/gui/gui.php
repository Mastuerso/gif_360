<?php

    $file="/home/onikom/Gif_Creator/main/gif_settings.txt";

    $document=file_get_contents($file);

    $lines=explode("\n",  $document);
    //$gif_attr=array();
    $delay;
    $loop;
    $patrol_cycle;
    $in_between;
    $quality;
    $freeze;
    $count=0;
    foreach($lines as $newline) {
        $newline=ltrim($newline, "delayloopplatrolcycle_gifinbetweenqualityfreezed_delay=");
        switch($count) {
            case 0:
                //$gif_atrr['delay']=$newline;
                $delay=$newline;
                //echo "Delay: ".$delay.'<br>';
                break;
            case 1:
                //$gif_atrr['loop']=$newline;
                $loop=$newline;
                //echo "Loop: ".$loop.'<br>';
                break;
            case 2:
                //$gif_atrr['patrol_cycle']=$newline;
                $patrol_cycle=$newline;
                //echo "Patrol cycle: ".$patrol_cycle.'<br>';
                break;
            case 3:
                //$gif_atrr['in_between']=$newline;
                $in_between=$newline;
                //echo "In between: ".$in_between.'<br>';
                break;
            case 4:
                //$gif_atrr['quality']=$newline;
                $quality=$newline;
                //echo "Quality: ".$quality.'<br>';
                break;
            case 5:
                $freeze=$newline;
                break;
            case 6:
                $cam_delay=$newline;
                //echo "Cam Delay: ".$cam_delay.'<br>';
                break;
        }        
        $count++;        
    }

    /*
    echo "Delay: ".$gif_atrr['delay'].'<br>';
    echo "Loop: ".$gif_atrr['loop'].'<br>';
    echo "Patrol cycle: ".$gif_atrr['patrol_cycle'].'<br>';
    echo "In-betweens: ".$gif_atrr['in_between'].'<br>';
    echo "Quality: ".$gif_atrr['quality'].'<br>';
    */
?>

<html>
    <head>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="stylesheet.css" >
    </head>
    <body>
        <h1>III6T</h1>
        <form action="gui_data.php" method="post">
            Freeze: 
            <?php
                if ($freeze==0){
                    echo '<input type="checkbox" name="freeze" value="true"><br>';
                    echo '<input type="text" name="cam_delay" value="'.$cam_delay.'" placeholder="Cam delay(ms)":><br>';
                } else {
                    echo '<input type="checkbox" name="freeze" value="true" checked><br>';                    
                }
            ?>
            <!--Delay: -->
            <input type="text" name="delay" value="<?=$delay?>" placeholder="Img delay(cs)":><br>
            <!--Quality(%): -->
            <input type="text" name="quality" value="<?=$quality?>" placeholder=Quality(%):><br>
            Loop the gif: 
            <?php
                if ($loop==0){
                    echo '<input type="checkbox" name="loop" value="true" checked><br>';
                } else
                    echo '<input type="checkbox" name="loop" value="true"><br>';
                
            ?>
            Create in betweens: 
            <?php
                if ($in_between==0){
                    echo '<input type="checkbox" name="in_between" value="true"><br>';
                } else
                    echo '<input type="checkbox" name="in_between" value="true" checked><br>';
                
            ?>
            Patrol cycle gif: 
            <?php
                if ($patrol_cycle==0){
                    echo '<input type="checkbox" name="patrol_cycle" value="true"><br>';
                } else
                    echo '<input type="checkbox" name="patrol_cycle" value="true" checked><br>';
                
            ?>
            <input type="submit" value="Ok">
        </form>
    </body>
</html>
