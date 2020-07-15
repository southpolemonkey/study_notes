
// inputStream to string conversion
// situtation: When maven package resources folder into jar, code need to reference files as inputStream
// if use File(), it will give your FileNotFound exception.

// Couple ways you can do
// Guava package; Apache Commons IO; Java 8
// https://www.baeldung.com/convert-input-stream-to-string

String text = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))
                                                .lines()
                                                .collect(Collectors.joining("\n"));


/**
 * Read file from resource folder, using file is less ideal 
 * https://stackoverflow.com/questions/43461978/jar-not-using-resources-correctly-maven
 */

File file = new File(getClass().getClassLoader().getResource("database.properties").getFile());
InputStream inputStream = getClass().getClassLoader().getResourceAsStream("database.properties");                                  


/**
 * Common JSON library in java
 * Jackson
 * json-simple
 * fast-json
 * 
 * Mostly you are dealing with two types: JsonArray and JsonObject, and expect to deal with nested json.
 */

// The example(https://www.journaldev.com/2324/jackson-json-java-parser-api-example-tutorial#jackson-json-8211-converting-json-to-map) 
// use jackson package
// Starts with the prevalant API ObjectMapper.readValue. But be aware that you need to define the
// corresponding java class first.
ObjectMapper objectMapper = new ObjectMapper();
ClassName cls = objectMapper.readValue(JsonString, ClassName.class);

// either way, parse to map object directly
Map<String,String> myMap = new HashMap<String, String>();
myMap = objectMapper.readValue(mapData, HashMap.class);

// second approach
JsonNode jsonNode = objectMapper.readTree(JsonString);
JsonNode idNode = rootNode.path("key");

// Use lower level JsonParse
JsonFactory factory = new JsonFactory();
JsonParser  parser  = factory.createParser(JsonString);


/**
 * Maven plugins
 * 
 * copy customed resources folder to jar
 * https://maven.apache.org/plugins/maven-resources-plugin/examples/copy-resources.html
 * 
 * I've new to maven, here lists down some confusions and hoping to understand in the future.
 * 
 * - what's the difference between run code with java <app_name> and mvn exec <app_namme>?
 * - Can I run multiple main class?
 */

System.out.println("Maven");

/**
 * Assert values in test
 * 
 * Sounds easy, but it gives me some trouble when actually doing it.
 * Senarios:
 * - Compare string
 * - Compare hashmap (discard order)
 * - Compare Json
 */

// I'm tired after submitting one challenge, leave the link here and check out later.
// https://www.baeldung.com/java-compare-hashmaps
