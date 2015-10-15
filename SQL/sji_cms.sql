-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2015 at 01:01 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sji_cms`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
`id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comment` text NOT NULL,
  `time_posted` varchar(50) NOT NULL,
  `post_id` int(11) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `name`, `comment`, `time_posted`, `post_id`, `modified`) VALUES
(5, 'Clinton Dsouza', 'Show some love for Batman', '2015-10-15 12:53:51 am', 1, '0000-00-00 00:00:00'),
(6, 'Anonymous', 'I''m in the nights watch and i find this offensive', '2015-10-15 12:57:06 am', 2, '0000-00-00 00:00:00'),
(12, 'Claude Sipes', 'I love Tuna', '2015-10-15 3:54:56 pm', 25, '0000-00-00 00:00:00'),
(13, 'Anonymous', 'Really Tuna??', '2015-10-15 3:55:35 pm', 25, '0000-00-00 00:00:00'),
(14, 'Eda Lang', 'Im allergic to fish', '2015-10-15 3:57:01 pm', 25, '0000-00-00 00:00:00'),
(15, 'Anonymous', 'Why you post about fish?', '2015-10-15 4:04:48 pm', 25, '0000-00-00 00:00:00'),
(16, 'Anonymous', 'i want a tuna sandwhich', '2015-10-15 4:08:04 pm', 25, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `mail`
--

CREATE TABLE IF NOT EXISTS `mail` (
`id` int(11) NOT NULL,
  `sender_name` varchar(100) NOT NULL,
  `sender_email` varchar(100) NOT NULL,
  `sender_subject` varchar(100) NOT NULL,
  `sender_message` text NOT NULL,
  `sent_time` varchar(50) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mail`
--

INSERT INTO `mail` (`id`, `sender_name`, `sender_email`, `sender_subject`, `sender_message`, `sent_time`, `modified`) VALUES
(1, 'Grady Robel', 'Grady_Robel@hotmail.com', 'Needed Info', 'Pricing of the cms', '2015-10-15 2:47:52 am', '0000-00-00 00:00:00'),
(4, 'Shawn Wolff', 'Shawn33@gmail.com', 'Pretty cool idea', 'Wish you all the best', '2015-10-15 2:52:10 am', '0000-00-00 00:00:00'),
(6, 'Clinton D', 'clinton92@gmail.com', 'Test Email', 'Hi Plz reply to this', '2015-10-15 6:25:23 am', '0000-00-00 00:00:00'),
(8, 'Clinton Dsouza', 'clinton92@gmail.com', 'Test Mail', 'Hope you get this', '2015-10-15 4:00:45 pm', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
`id` int(11) NOT NULL,
  `post_title` varchar(100) NOT NULL,
  `post_content` text NOT NULL,
  `publish_date` varchar(50) DEFAULT NULL,
  `is_draft` tinyint(1) NOT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `parent_page_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `post_title`, `post_content`, `publish_date`, `is_draft`, `author_name`, `modified`, `parent_page_id`) VALUES
(1, 'Batman Ipsum - Update', '<p>Update</p>\n\n<p>Batman: Bruce Wayne, eccentric billionaire.</p>\n\n<p>Two-Face: I just the took to calling it the Bat. And yes Mr. Wayne, it does come in black.</p>\n\n<p>Batman: I&#39;m not wearing hockey pads.</p>\n\n<p>Bane: You fight like a younger man, there&#39;s nothing held back. It&#39;s admirable, but mistaken.</p>\n\n<p>Two-Face: Bruce Wayne! Design, live and breathe. What brings you out of the prior sleep, Mr. Wayne?</p>\n\n<p>Rachel: You care about justice? Look beyond your own pain, Bruce. This city is rotting.</p>\n\n<p>Batman: The first time I stole so that I wouldn&#39;t starve, yes. I lost many assumptions about the simple nature of right and wrong. And when I traveled I learned the fear before a crime and the thrill of success. But I never became one of them.</p>\n\n<p>Random Guy: You are in hell, little man. And I am the devil.</p>\n\n<p>Joker: If you&#39;re good at something, never do it for free.</p>\n\n<p>Batman: I will go back to Gotham and I will fight men Iike this but I will not become an executioner.</p>\n\n<p>Alfred: Batman may have made the front page but Bruce Wayne got pushed to page eight.</p>\n\n<p>Lucius Fox: Very well. Death! By exile.</p>\n\n<p>Alfred: You hung up your cape and your cowl but you didn&#39;t move on. You never went to find a life.</p>\n\n<p>Ra&#39;s Al Ghul: When a forest grows too wild, a purging fire is inevitable and natural. Tomorrow the world will watch in horror as its greatest city destroys itself. The movement back to harmony will be unstoppable this time.</p>\n', '2015-10-15 11:31:24 am', 0, 'Clinton Dsouza', '2015-10-15 06:01:24', 0),
(2, 'Title fit for a (precariously enthroned) king', '<p>Lorem no song so sweet, consectetur adipisicing elit, sed do eiusmod drink, your king commands it tread lightly here. Neeps enim righteous in wrath, honeyed locusts never resting spare me your false courtesy winter is coming. Duis maegi irure dolor in reprehenderit in suckling pig esse mare&#39;s milk crimson beware our sting. No foe may pass bloody mummers, sunt we do not sow poison is a woman&#39;s weapon laborum.</p>\n\n<p>Ward pretium tincidunt lacus. Moon and stars brother clansmen. Bannerman varius, milk of the poppy, est eros dagger sorcery, full of terrors garrison mulled wine. Though all men do despise us chamber. Duis let it be written vulputate vehicula. As high as honor mace. Etiam greyscale. Princess fire, your grace the wall, eros est euismod turpis, id tincidunt sapien none so wise. Always pays his debts. Ever vigilant. Death fleet in his cups. Old bear sister, seven hells, the seven, night&#39;s watch, coin. Green dreams, a taste of glory, felis nisl arbor gold, sed feed it to the goats. You know nothing sorcery. Nullam arcu. Lance feast. Wolf moon-flower juice, cell baseborn, laoreet dungeon, honeyed locusts, half-man. Aenean magna nisl, spiced wine, suckling pig, ever vigilant, orci. In our sun shines bright.</p>\n\n<p>Mare&#39;s milk, lamprey gallant the wall, lord of light nuncle, sed placerat ipsum urna seven hells. Garrison always pays his debts. Dragons moon and stars work her will. Mauris a lacus. Donec mattis bloody mummers. Crypt never resting platea dictumst. Vivamus facilisis diam at odio. Mauris smallfolk, nisi eget the seven, we light the way, non feugiat orci magna ac wolf. Donec turpis. Usurper old bear. Morbi tristique none so fierce. The last of the dragons. Proin turpis lacus, scelerisque vitae, wench neeps, moon-flower juice, godswood. Aliquam dictum eleifend risus. In hac habitasse platea dictumst. Etiam sit amet diam. Suspendisse odio. Spiced wine. Rouse me not libero.</p>\n\n<p>Mulled wine, lacus eget pulvinar lacinia, pede crimson dignissim leo, green dreams spiced wine magister the wall. Mare&#39;s milk. Nuncle seven hells, dapibus sed, clansmen eget, honeyed locusts, sandsilk. Nam quis lacus. Nunc eleifend snow murder. Morbi lobortis quam eu velit. Donec euismod cold royal. Chamber the seven. No song so sweet old bear. Cras dignissim pride and purpose. Prince non diam. Cloak habitant let me soar ours is the fury fames ac your grace. Honed and ready platea dictumst. Aenean whore. Night&#39;s watch full of terrors. Nunc sun no foe may pass dapibus.</p>\n\n<p>Aliquam vehicula sem godswood usurper. Moon-flower juice magister, arbor gold, never resting, bloody mummers, m&#39;lord. We do not sow. Donec vitae nisi. Merchant take the black. Duis sed elit ut turpis ullamcorper feugiat. Throne wench, mauris tread lightly here, milk of the poppy, cell winter is coming a justo. He asked too many questions. Ever vigilant summerwine. Mulled wine. Beware our sting. The wall. In his cups.</p>\n', '2015-10-12 10:07:01 pm', 0, 'Clinton Dsouza', '2015-10-14 12:19:46', 0),
(3, 'Cupcake Ipsum - Update 2.0', '<p>Update 2.0</p>\n\n<p>Oat cake liquorice lollipop gummi bears fruitcake. Lollipop gummies macaroon candy wafer ice cream. Macaroon cheesecake jelly-o. Tart biscuit cake candy canes gummies carrot cake oat cake lollipop. Gingerbread gummies oat cake gummi bears wafer apple pie. Gummies lollipop cupcake.</p>\n\n<p>Pie jujubes donut cupcake gummies cake. Chocolate cake tootsie roll cake sesame snaps caramels. Carrot cake jelly pudding bear claw tiramisu gummi bears. Jelly beans pudding marzipan. Halvah cookie apple pie chocolate bear claw macaroon macaroon liquorice fruitcake. Sesame snaps cake toffee gingerbread chocolate apple pie. Gingerbread apple pie lemon drops fruitcake. Gummies wafer icing. Icing sesame snaps macaroon muffin. Pudding muffin marshmallow candy canes chocolate bar oat cake wafer dessert fruitcake.</p>\n\n<p>Drag&eacute;e chupa chups marshmallow cake cake jelly. Lemon drops cotton candy jelly-o pudding lollipop cotton candy gummi bears. Cupcake macaroon cupcake liquorice. Topping apple pie cupcake apple pie sesame snaps cookie brownie jelly-o. Gummi bears cupcake chupa chups sweet. Bonbon gingerbread muffin bonbon liquorice tiramisu croissant oat cake. Sweet wafer lollipop sesame snaps drag&eacute;e brownie cookie. Fruitcake fruitcake gingerbread souffl&eacute; sesame snaps fruitcake apple pie chocolate bar. Cupcake gummi bears sweet roll brownie icing oat cake. Dessert caramels cotton candy macaroon tootsie roll.</p>\n\n<p>Pie pie chocolate caramels cake pie icing tart marzipan. Chocolate cake pastry oat cake pudding. Carrot cake jujubes tootsie roll chupa chups gummi bears muffin halvah jelly-o candy. Jelly beans pastry marshmallow apple pie. Croissant souffl&eacute; souffl&eacute; chupa chups fruitcake. Fruitcake chocolate marzipan powder jelly beans jelly-o candy bear claw. Jujubes liquorice donut drag&eacute;e. Chocolate bar chocolate cake sesame snaps chocolate souffl&eacute; chupa chups jujubes macaroon. Chocolate cake souffl&eacute; drag&eacute;e marzipan. Brownie pudding cotton candy tiramisu cupcake marshmallow.</p>\n\n<p>Caramels sesame snaps drag&eacute;e chocolate cake pie chocolate bar bear claw danish jelly-o. Jelly beans cake souffl&eacute; pie. Toffee marshmallow sugar plum marzipan powder drag&eacute;e caramels halvah jelly beans. Icing marzipan brownie oat cake. Caramels bear claw jelly beans. Gummi bears wafer drag&eacute;e chocolate cake. Cake souffl&eacute; sweet roll ice cream gummi bears. Chupa chups cake liquorice cake carrot cake fruitcake candy canes jujubes. Liquorice lemon drops cake danish.</p>\n', '2015-10-13 7:47:01 pm', 0, 'Clinton Dsouza', '2015-10-14 12:19:03', 0),
(4, 'The most presidential lorem ipsum in history.', '<p>That we can tuck in our children at night and know that they are fed and clothed and safe from harm. But then I asked myself: Are we serving Shamus as well as he is serving us? So it&#39;s 1985, and I&#39;m in Chicago, and I&#39;m working with these churches, and with lots of laypeople who are much older than I am. And so this will be a difficult debate next week. And meeting them won&#39;t be easy. The times are too serious, the stakes are too high for this same partisan playbook.</p>\n\n<p>We shouldn&#39;t use the obstacles we face as an excuse for cynicism. If John McCain wants to follow George Bush with more tough talk and bad strategy, that is his choice - but it is not the change we need. And I will restore our moral standing, so that America is once again that last, best hope for all who are called to the cause of freedom, who long for lives of peace, and who yearn for a better future. Those are not just American ideas, they are human rights, and that is why we will support them everywhere.</p>\n\n<p>They claim that our insistence on something larger, something firmer and more honest in our public life is just a Trojan Horse for higher taxes and the abandonment of traditional values. Fear that because of modernity we will lose of control over our economic choices, our politics, and most importantly our identities - those things we most cherish about our communities, our families, our traditions, and our faith. The Holy Koran tells us, &quot;O mankind! We have created you male and a female; and we have made you into nations and tribes so that you may know one another.&quot;</p>\n\n<p>Our conscience cannot rest until we not only secure our borders, but give the 12 million undocumented immigrants in this country a chance to earn their citizenship by paying a fine and waiting in line behind all those who came here legally. Now Ashley might have made a different choice. These challenges are not all of government&#39;s making. I know there are those who dismiss such beliefs as happy talk. This cycle of suspicion and discord must end.</p>\n\n<p>That we can tuck in our children at night and know that they are fed and clothed and safe from harm. And Ashley said that when she was nine years old, her mother got cancer. More of you have lost your homes and even more are watching your home values plummet. In all nations - including my own - this change can bring fear.</p>\n\n<p>Thank you, and God bless America.</p>\n', '2015-10-12 10:27:15 pm', 0, 'Clinton Dsouza', '2015-10-14 12:19:11', 0),
(5, 'Quote Ipsum', '<p>Make the most of today. Translate your good intentions into actual deeds. I am only one, but still I am one. I cannot do everything, but still I can do something; and because I cannot do everything, I will not refuse to do something I can do. If you are not fired with enthusiasm, you will be fired with enthusiasm. If you do not do it excellently, do not do it at all. Because if it is not excellent, it will not be profitable or fun, and if you are not in business for fun or profit, what the hell are you doing there? We can try to avoid making choices by doing nothing, but even that is a decision. First we will be best, and then we will be first.</p>\n\n<p>When you cease to make a contribution you begin to die. Make the most of today. Translate your good intentions into actual deeds. Why not go out on a limb? That is where the fruit is In the long run, men hit only what they aim at. Therefore, they had better aim at something high. The Universe Law is impartial. It will give you anything you believe. It will throw you garbage or roses depending on the energy you put in. You are the one in charge, and you must accept that and stand alone. If you think God is coming down to fix things for you, forget it. God is out playing golf Begin to be now what you will be hereafter. Do not compromise yourself. You are all you have got. When one door closes another opens. Expect that new door to reveal even greater wonders and glories and surprises. Feel yourself grow with every experience. And look for the reason for it</p>\n\n<p>Begin difficult things while they are easy. A thousand-mile journey begins with one step. If you cannot do great things, do small things in a great way. Some people have greatness thrust upon them. Very few have excellence thrust upon them. Why not go out on a limb? That is where the fruit is Failure should be our teacher, not our undertaker. Failure is delay, not defeat. It is a temporary detour, not a dead end. Failure is something we can avoid only by saying nothing, doing nothing, and being nothing.</p>\n', 'Null', 1, 'Clinton Dsouza', '2015-10-12 20:55:41', 0),
(6, 'Yet another Batman Ipsum', '<p>I&#39;m here to ensure the League of Shadow fulfills its duty to restore balance to civilization. You yourself fought the decadence of Gotham for years with all your strength, all your resources, all your moral authority. And the only victory you achieved was a lie. Now, you understand? Gotham is beyond saving and must be allowed to die.</p>\n\n<p>Behind you, stands a symbol of oppression. Blackgate Prison, where a thousand men have languished under the name of this man: Harvey Dent.</p>\n\n<p>Bruce Wayne! Design, live and breathe. What brings you out of the prior sleep, Mr. Wayne?</p>\n\n<p>But no ordinary child, a child born in hell, forged from suffering, hardened by pain. Not a man from privilege.</p>\n\n<p>A little the worse for wear, I&#39;m afraid.</p>\n\n<p>Every year, I took a holiday. I went to Florence, this cafe on the banks of the Arno. Every fine evening, I would sit there and order a Fernet Branca. I had this fantasy, that I would look across the tables and I would see you there with a wife maybe a couple of kids. You wouldn&#39;t say anything to me, nor me to you. But we would both know that you&#39;ve made it, that you were happy. I never wanted you to come back to Gotham. I always knew there was nothing here for you except pain and tragedy and I wanted something more for you than that. I still do.</p>\n\n<p>It will be extremely painful... for you</p>\n\n<p>Justice is about harmony. Revenge is about you making yourself feel better.</p>\n\n<p>Why do we fall, sir? So that we can learn to pick ourselves up.</p>\n\n<p>This is what happens when an unstoppable force meets an immovable object.</p>\n\n<p>Do I really look like a guy with a plan?</p>\n\n<p>You must become more than just a man in the mind of you opponent.</p>\n\n<p>I just the took to calling it the Bat. And yes Mr. Wayne, it does come in black.</p>\n\n<p>You can swapnot sleeping in a penthouse... for not sleeping in a mansion. Whenever you stitch yourself up, you do make a bloody mess.</p>\n', '2015-10-22 11:00:00 pm', 0, 'Clinton Dsouza', '2015-10-14 12:19:18', 1),
(9, 'Yet another Harry Potter ipsum', '<p>Thestral dirigible plums, Viktor Krum hexed memory charm Animagus Invisibility Cloak three-headed Dog. Half-Blood Prince Invisibility Cloak cauldron cakes, hiya Harry! Basilisk venom Umbridge swiveling blue eye Levicorpus, nitwit blubber oddment tweak. Chasers Winky quills The Boy Who Lived bat spleens cupboard under the stairs flying motorcycle. Sirius Black Holyhead Harpies, you&rsquo;ve got dirt on your nose. Floating candles Sir Cadogan The Sight three hoops disciplinary hearing. Grindlewald pig&rsquo;s tail Sorcerer&#39;s Stone biting teacup. Side-along dragon-scale suits Filch 20 points, Mr. Potter.</p>\n\n<p>Squashy armchairs dirt on your nose brass scales crush the Sopophorous bean with flat side of silver dagger, releases juice better than cutting. Full moon Whomping Willow three turns should do it lemon drops. Locomotor trunks owl treats that will be 50 points, Mr. Potter. Witch Weekly, he will rise again and he will come for us, headmaster Erumpent horn. Fenrir Grayback horseless carriages &lsquo;zis is a chance many would die for!</p>\n\n<p>Boggarts lavender robes, Hermione Granger Fantastic Beasts and Where to Find Them. Bee in your bonnet Hand of Glory elder wand, spectacles House Cup Bertie Bott&rsquo;s Every Flavor Beans Impedimenta. Stunning spells tap-dancing spider Slytherin&rsquo;s Heir mewing kittens Remus Lupin. Palominos scarlet train black robes, Metamorphimagus Niffler dead easy second bedroom. Padma and Parvati Sorting Hat Minister of Magic blue turban remember my last.</p>\n', '2015-10-13 1:28:55 pm', 0, 'Clinton Dsouza', '2015-10-14 12:20:03', 0),
(10, 'Vegetable Ipsum', '<p>Veggies es bonus vobis, proinde vos postulo essum magis kohlrabi welsh onion daikon amaranth tatsoi tomatillo melon azuki bean garlic.</p>\n\n<p>Gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato. Dandelion cucumber earthnut pea peanut soko zucchini.</p>\n\n<p>Turnip greens yarrow ricebean rutabaga endive cauliflower sea lettuce kohlrabi amaranth water spinach avocado daikon napa cabbage asparagus winter purslane kale. Celery potato scallion desert raisin horseradish spinach carrot soko. Lotus root water spinach fennel kombu maize bamboo shoot green bean swiss chard seakale pumpkin onion chickpea gram corn pea. Brussels sprout coriander water chestnut gourd swiss chard wakame kohlrabi beetroot carrot watercress. Corn amaranth salsify bunya nuts nori azuki bean chickweed potato bell pepper artichoke.</p>\n', '2015-10-13 1:36:57 pm', 0, 'Clinton Dsouza', '2015-10-14 12:20:09', 1),
(15, 'Web 2.0 ipsum...Again', '<p>Webtwo ipsum dolor sit amet, eskobo chumby doostang bebo. Omgpop yoono yuntaa scribd zimbra spotify jaiku spock diigo spotify, tivo imeem whrrl gooru kiko imeem gsnap disqus convore handango, elgg dopplr nuvvo handango eskobo kosmix hipmunk revver spotify. Etsy loopt lijit balihoo jibjab zoodles dopplr blyve spotify, wesabe plugg boxbe wesabe balihoo squidoo hojoki, sifteo balihoo skype qeyno orkut yuntaa meevee. Octopart hulu ideeli sifteo shopify sclipo heroku zoho zillow, spock heroku zynga jumo octopart sifteo voki bitly cuil, zappos oooj yoono woopra doostang lanyrd babblely. Boxbe woopra vuvox joyent, kiko blekko dropio kippt, meebo foodzie.&nbsp;</p>\n\n<p>Wufoo wikia dropio movity eskobo hipmunk orkut doostang akismet chartly flickr zapier, spotify jaiku dropio twones boxbe oovoo nuvvo zoosk vuvox koofers, kazaa imeem vimeo kno skype jabber eduvant spock prezi plaxo. Edmodo appjet mog sococo jajah zoho jiglu geni sifteo dropio vimeo wikia spotify, eduvant zoodles zlio zoho plugg greplin wesabe lala diigo octopart mzinga. Kosmix movity kaboodle appjet cotweet revver meebo zlio octopart yammer, zynga convore airbnb glogster orkut wesabe kippt jumo twones hojoki, zooomr yammer oooooc hojoki grockit jumo prezi kazaa. Oooooc spotify zillow, orkut.&nbsp;</p>\n\n<p>Kaboodle zoho orkut chumby heekya stypi divvyshot tivo cuil zillow, voki boxbe sclipo edmodo chartly geni vuvox blekko mzinga kosmix, yuntaa blekko hojoki greplin palantir voki joyent unigo. Balihoo yammer ebay jajah handango plickers handango sococo ning dopplr revver trulia wikia zynga kiko kno imeem elgg voki, zimbra loopt zappos flickr nuvvo plaxo kazaa odeo quora loopt ifttt akismet lanyrd scribd mobly waze zoodles. Ifttt zanga prezi squidoo blippy jumo joyent, akismet zapier meebo twitter convore, tivo plickers yoono woopra palantir. Meevee wufoo bitly vimeo glogster, wikia hipmunk.&nbsp;</p>\n', '2015-10-13 4:48:42 pm', 0, 'Clinton Dsouza', '2015-10-14 12:20:23', 2),
(16, 'Gotta love Batman', '<p>The first time I stole so that I wouldn&#39;t starve, yes. I lost many assumptions about the simple nature of right and wrong. And when I traveled I learned the fear before a crime and the thrill of success. But I never became one of them.</p>\n\n<p>As Gotham&#39;s favored son you will be ideally placed to strike at the heart of criminality.</p>\n\n<p>You&#39;re taller than you look in the tabIoids, Mr. Wayne.</p>\n\n<p>Take a look, his speed, his ferocity, his training. I see the power of belief. I see the League of Shadows resurgent.</p>\n\n<p>I&#39;m here to ensure the League of Shadow fulfills its duty to restore balance to civilization. You yourself fought the decadence of Gotham for years with all your strength, all your resources, all your moral authority. And the only victory you achieved was a lie. Now, you understand? Gotham is beyond saving and must be allowed to die.</p>\n\n<p>You know how to disappear. We can teach you to become truly invisible.</p>\n\n<p>You wanna know how I got them? So I had a wife. She was beautiful, like you, who tells me I worry too much, who tells me I ought to smile more, who gambles and gets in deep with the sharks. Hey. One day they carve her face. And we have no money for surgeries. She can&#39;t take it. I just wanna see her smile again. I just want her to know that I don&#39;t care about the scars. So, I do this to myself. And you know what? She can&#39;t stand the sight of me. She leaves. Now I see the funny side. Now I&#39;m always smiling.</p>\n\n<p>But we&#39;ve met before. That was a long time ago, I was a kid at St. Swithin&#39;s, It used to be funded by the Wayne Foundation. It&#39;s an orphanage. My mum died when I was small, it was a car accident. I don&#39;t remember it. My dad got shot a couple of years later for a gambling debt. Oh I remember that one just fine. Not a lot of people know what it feels like to be angry in your bones. I mean they understand. The fosters parents. Everybody understands, for a while. Then they want the angry little kid to do something he knows he can&#39;t do, move on. After a while they stop understanding. They send the angry kid to a boy&#39;s home, I figured it out too late. Yeah I learned to hide the anger, and practice smiling in the mirror. It&#39;s like putting on a mask. So you showed up this one day, in a cool car, pretty girl on your arm. We were so excited! Bruce Wayne, a billionaire orphan? We used to make up stories about you man, legends and you know with the other kids, that&#39;s all it was, just stories, but right when I saw you, I knew who you really were. I&#39;d seen that look on your face before. It&#39;s the same one I taught myself. I don&#39;t why you took the fault for Dent&#39;s murder but I&#39;m still a believer in the Batman. Even if you&#39;re not...</p>\n\n<p>They scream and they cry much as you&#39;re doing now.</p>\n\n<p>Do you want my opinion? You need to lighten up.</p>\n\n<p>Hero can be anyone. Even a man knowing something as simple and reassuring as putting a coat around a young boy shoulders to let him know the world hadn&#39;t ended.</p>\n\n<p>You want order in Gotham. Batman must take off his mask and turn himself in. Oh, and every day he doesn&#39;t, people will die. Starting tonight. I&#39;m a man of my word.</p>\n\n<p>All creatures feel fear. Especially the scary ones.&nbsp;</p>\n\n<p>I&#39;m Gotham&#39;s reckoning. It&#39;ll end the ball of damns you&#39;ve all been living on. A necessary evil.</p>\n', '2015-10-13 4:50:50 pm', 0, 'Clinton Dsouza', '2015-10-14 12:19:35', 6),
(25, 'Tuna Ipsum - Updated', '<p>P&iacute;ntano Arctic char stingray neon tetra vimba dwarf gourami morwong pirarucu tope treefish bonytongue featherfin knifefish scorpionfish yellow weaver. Beardfish electric catfish Pacific lamprey weeverfish gulper, sailbearer, tilefish mullet long-whiskered catfish lagena carp titan triggerfish. Ghost flathead flounder stickleback Peter&#39;s elephantnose fish nurseryfish. Leopard danio pollyfish hillstream loach yellowtail kingfish Norwegian Atlantic salmon. Ratfish merluccid hake chain pickerel northern squawfish inanga false cat shark squeaker burma danio electric stargazer trevally Indian mul stingfish striped burrfish skilfish. Norwegian Atlantic salmon sea dragon flying characin: archerfish.</p>\n\n<p>Cobbler lionfish trunkfish mola Shingle Fish sheatfish Blobfish four-eyed fish crocodile icefish. Sand knifefish sabertooth combtail gourami, electric stargazer goldspotted killifish. Roosterfish kokanee toadfish Black scalyfin salamanderfish sawtooth eel denticle herring yellowtail pygmy sunfish? Pupfish spikefish mako shark jewfish guitarfish denticle herring! Sand goby, herring javelin climbing perch forehead brooder trumpeter; wahoo bat ray angler. Dogteeth tetra emperor angelfish scat weatherfish longfin smelt airbreathing catfish finback cat shark. Carpetshark labyrinth fish collared dogfish Dolly Varden trout butterfly ray tube-eye lookdown catfish. Bonnetmouth oceanic whitetip shark blue triggerfish weasel shark; Australian prowfish. Mudminnow freshwater eel escolar Dolly Varden trout sabertooth rockfish john dory amago. Pike conger goldeye bigeye squaretail platyfish, pearl perch: gombessa; gombessa murray cod southern hake grass carp.</p>\n\n<p>Spiderfish x-ray tetra slickhead, alfonsino crocodile icefish velvet-belly shark upside-down catfish rock bass ballan wrasse, lyretail. Smalltooth sawfish zander, mudminnow freshwater herring flashlight fish snapper oceanic whitetip shark, &quot;African glass catfish.&quot; Mackerel yellowfin croaker amago Billfish frogfish blackfish, round whitefish trahira. Lake whitefish baikal oilfish ladyfish driftfish huchen duckbilled barracudina cutlassfish coelacanth eelblenny kelp perch blue shark, coley; Blind goby. Cat shark ribbon sawtail fish tidewater goby California flyingfish combtail gourami. Crappie largenose fish zebra bullhead shark, sheatfish largenose fish longnose sucker, sauger, ling oarfish, baikal oilfish. North American freshwater catfish dragonfish whiptail gulper yellow jack firefish halibut deep sea bonefish rough sculpin pumpkinseed lamprey. Temperate ocean-bass tilefish surf sardine yellowtail horse mackerel Bigscale pomfret wobbegong burbot seamoth stoneroller minnow false brotula warmouth ballan wrasse. Sand tiger velvet-belly shark sockeye salmon Cherubfish houndshark: needlefish pollock whiptail gulper. Paperbone cepalin; coolie loach mummichog bullhead shark Manta Ray. Triplespine: green swordtail codlet northern pearleye snake mudhead barbeled dragonfish lanternfish, Redfin perch Atlantic silverside mud catfish: piranha clown loach electric ray. Livebearer loach croaker Modoc sucker codlet.</p>\n\n<p>Brown trout, forehead brooder goldeye. Muskellunge stingfish yellowbanded perch, luminous hake kelpfish boxfish river loach whiff: eelblenny, Chinook salmon. Surfperch pollock golden trout ilisha kahawai ide stingray beluga sturgeon lanternfish grideye rock beauty pleco. Priapumfish bull shark bent-tooth squirrelfish, queen parrotfish; duckbill eel; yellow-eye mullet whale shark pike merluccid hake. Smalleye squaretail Oriental loach yellowmargin triggerfish cuchia rough sculpin Red salmon Celebes rainbowfish.</p>\n\n<p>White croaker Spanish mackerel angelfish Pacific hake cherry salmon, kaluga zander Oregon chub. Eelblenny barracuda Alaska blackfish pompano dolphinfish sea bass pomfret duckbilled barracudina tench roughy. Black mackerel, Moses sole, whalefish. Barfish longfin escolar. Northern squawfish oilfish duckbill boarfish naked-back knifefish, longfin sockeye salmon coho salmon poacher Canthigaster rostrata, African lungfish prickly shark. Ghost knifefish; Chinook salmon bandfish frigate mackerel saw shark french angelfish guppy. Scissor-tail rasbora wahoo boarfish grayling coho salmon zebrafish banded killifish. Emperor angelfish Molly Miller zebra shark giant gourami yellow-eye mullet northern clingfish threespine stickleback, darter, redlip blenny kelp perch rock beauty? Longfin escolar pikeperch: flashlight fish danio pilchard; wahoo. Northern sea robin, silver dollar yellowtail clownfish sweeper milkfish fingerfish New Zealand sand diver New Zealand sand diver.</p>\n\n<p>&nbsp;</p>\n\n<p>Does your lorem ipsum text long for something a little fishier? Give our generator a try&hellip; it&rsquo;s fishy!</p>\n', '2015-10-15 3:52:13 pm', 0, 'Clinton Dsouza', '2015-10-15 10:22:13', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `temp_password` varchar(100) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `temp_password`, `username`, `role`, `modified`) VALUES
(1, 'clinton92@gmail.com', '14a292b6f5cfe1e7f35a22de9c4154b4', '', 'Clinton Dsouza', 'admin', '2015-10-15 06:53:51'),
(7, 'clinton_dsouza92@yahoo.com', '14a292b6f5cfe1e7f35a22de9c4154b4', NULL, 'Clinton D', 'content_manager', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail`
--
ALTER TABLE `mail`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `email_id` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `mail`
--
ALTER TABLE `mail`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
