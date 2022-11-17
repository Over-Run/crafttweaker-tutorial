#priority 100;

import crafttweaker.event.PlayerInteractBlockEvent as PIBE;
import crafttweaker.event.PlayerInteractEvent;
import crafttweaker.events.IEventManager;
import crafttweaker.event.IPlayerEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.event.IEventPositionable;
import crafttweaker.block.IBlockDefinition;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.entity.IEntityEquipmentSlot;
// 实现 点石成钻石块，并消耗一颗钻石
events.onPlayerInteractBlock(function(event as PIBE) {
    val player = event.player;
    val world = event.world;
    val pos = event.position;
    val blockDefId = event.block.definition.id;
    
    val stoneId = <minecraft:stone>.definition.id;
    val diamondId = <minecraft:diamond>.definition.id;
    val diamondBlockState = <blockstate:minecraft:diamond_block>;
    if(!world.remote && blockDefId == stoneId) {
        //放在里面只用于判断一次为了防止多次触发的空值
        val itemDefId = event.item.definition.id;
        if(itemDefId == diamondId) {
            world.setBlockState(diamondBlockState, pos);
            val temp = player.currentItem.splitStack(player.currentItem.amount - 1);

            player.setItemToSlot(IEntityEquipmentSlot.mainHand(), temp);
        }
        
    }
    /*
        stoneId 这串是IItemStack的IItemDefinition里面的参数id 示例<minecraft:stone>的 definition id为minecraft:stone    diamondId一样
        判断event.block.definition.id 是IBlock事件里面的IBlockDefinition 里面的参数id与IItemstack的类似具体看Wiki
        其中event.block的出处是在PlayerInteractBlock里面的PlayerInteract里的gettings， event.item也是
        IEntityEquipmentSlot.mainHand()为固定的枚举常量，常见的有
            crafttweaker.entity.IEntityEquipmentSlot.mainHand();主手
        crafttweaker.entity.IEntityEquipmentSlot.offhand();副手
        crafttweaker.entity.IEntityEquipmentSlot.feet();脚
        crafttweaker.entity.IEntityEquipmentSlot.legs();护腿
        crafttweaker.entity.IEntityEquipmentSlot.chest();胸甲
        crafttweaker.entity.IEntityEquipmentSlot.head();头盔
     */
});