const functions = require("firebase-functions");
const functions = require("firebase-admin");
const { Client } = require("@elastic/elasticsearch");

admin.initializeApp(functions.config().firebase);

const env = functions.config();

const auth = {
  username: env.elasticsearch.username,
  password: env.elasticsearch.password,
};

const client = new Client({
  node: env.elasticsearch.url,
  auth: auth,
});

exports.createPost = functions.firestore
  .document("sellers/{userId}")
  .onCreate(async (snap, context) => {
    await client.index({
      index: "orderID",
      type: "_doc",
      id: snap.id,
      body: snap.data(),
    });
  });

exports.updatePost = functions.firestore
  .document("users/{userId}")
  .onUpdate(async (snap, context) => {
    await client.index({
      index: "orderID",
      type: "_doc",
      id: snap.id,
      body: snap.after.data(),
    });
  });

exports.deletePost = functions.firestore
  .document("users/{userId}")
  .onDelete((snap) => {
    client.delete({
      index: "orderID",
      type: "doc",
      id: snap.id,
    });
  });

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
