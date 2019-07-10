const fastify = require('fastify')({
    logger: true
})

// Declare a route
fastify.get('/', async (request, reply) => {
 return {
  products: [
    {
      name: "Banana",
      image: "https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg",
      description: "A banana is an edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa.[3] In some countries, bananas used for cooking may be called 'plantains', distinguishing them from dessert bananas. The fruit is variable in size, color, and firmness, but is usually elongated and curved, with soft flesh rich in starch covered with a rind, which may be green, yellow, red, purple, or brown when ripe. The fruits grow in clusters hanging from the top of the plant. Almost all modern edible seedless (parthenocarp) bananas come from two wild species – Musa acuminata and Musa balbisiana. The scientific names of most cultivated bananas are Musa acuminata, Musa balbisiana, and Musa × paradisiaca for the hybrid Musa acuminata × M. balbisiana, depending on their genomic constitution. The old scientific name for this hybrid, Musa sapientum, is no longer used.",
      price: 1.5
    },
    {
      name: "Apple",
      image: "https://upload.wikimedia.org/wikipedia/commons/0/07/Honeycrisp-Apple.jpg",
      description: "An apple is a sweet, edible fruit produced by an apple tree (Malus domestica). Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus. The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today. Apples have been grown for thousands of years in Asia and Europe and were brought to North America by European colonists. Apples have religious and mythological significance in many cultures, including Norse, Greek and European Christian traditions.",
      price: 0.5
    },
    {
      name: "Orange",
      image: "https://upload.wikimedia.org/wikipedia/commons/7/7b/Orange-Whole-%26-Split.jpg",
      description: "The orange is the fruit of the citrus species Citrus × sinensis in the family Rutaceae. It is also called sweet orange, to distinguish it from the related Citrus × aurantium, referred to as bitter orange. The sweet orange reproduces asexually (apomixis through nucellar embryony); varieties of sweet orange arise through mutations.",
      price: 1
    },
    {
      name: "Kiwifruit",
      image: "https://upload.wikimedia.org/wikipedia/commons/d/d3/Kiwi_aka.jpg",
      description: "Kiwifruit (often abbreviated as kiwi outside New Zealand), or Chinese gooseberry, is the edible berry of several species of woody vines in the genus Actinidia. The most common cultivar group of kiwifruit (Actinidia deliciosa 'Hayward') is oval, about the size of a large hen's egg (5–8 cm (2.0–3.1 in) in length and 4.5–5.5 cm (1.8–2.2 in) in diameter). It has a thin, hair-like, fibrous, sour-but-edible light brown skin and light green or golden flesh with rows of tiny, black, edible seeds. The fruit has a soft texture with a sweet and unique flavour. China produced 50% of the world total of kiwifruit in 2017.",
      price: 4
    },
    {
      name: "Blackberry",
      image: "https://upload.wikimedia.org/wikipedia/commons/b/b5/Blackberry_fruits.jpg",
      description: "The blackberry is an edible fruit produced by many species in the genus Rubus in the family Rosaceae, hybrids among these species within the subgenus Rubus, and hybrids between the subgenera Rubus and Idaeobatus. The taxonomy of the blackberries has historically been confused because of hybridization and apomixis, so that species have often been grouped together and called species aggregates. For example, the entire subgenus Rubus has been called the Rubus fruticosus aggregate, although the species R. fruticosus is considered a synonym of R. plicatus.",
      price: 2.5
    },
  ]
}
})

   // Run the server!
const start = async () => {
try {
  await fastify.listen(3000)
  fastify.log.info(`server listening on ${fastify.server.address().port}`)
    } catch (err) {
      fastify.log.error(err)
      process.exit(1)
    }
}
start()
