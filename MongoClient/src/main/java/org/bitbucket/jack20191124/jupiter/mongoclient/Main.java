/*
 * Copyright Jiaqi (Jack)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.bitbucket.jack20191124.jupiter.mongoclient;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

import java.util.Arrays;

/**
 * A simple program that writs and then read from MongoDB container.
 */
public class Main {

    /**
     * A simple program that writs and then read from MongoDB container.
     *
     * @param args  No arguments
     *
     * @throws Exception if any errors occur during program execution
     */
    @SuppressWarnings({"checkstyle:UncommentedMain", "MultipleStringLiterals"})
    public static void main(final String[] args) throws Exception {
        /*
         * MongoClient is the route to MongoDB, from this you'll get your database and collections to work with. This
         * should be a singleton. MongoClient is effectively a connection pool. Using a single MongoClient allows the
         * driver to correctly manage connections to server.
         */
        final MongoClient client = new MongoClient(new MongoClientURI("mongodb://localhost:27017"));

        /*
         * MongoDB does not have tables, rows, columns, joins etc. Instead it has collections(like tables in SQL) and
         * documents (like rows in SQL). Collections can have indexes.
         *
         * If the database doesn't exist, it will be created automatically the first time you insert anything into it,
         * so there's no need for null checks or exception handling on the off-chance the database doesn't exist.
         */
        final DB db = client.getDB("human");
        final DBCollection collection = db.getCollection("people");

        final DBObject person = new BasicDBObject("_id", "jack")
                .append("name", "Jiaqi")
                .append(
                        "address",
                        new BasicDBObject("street", "123 Fake St")
                                .append("city", "Faketon")
                )
                .append("books", Arrays.asList(123, 456));

        collection.insert(person);

        // read from DB
        final DBObject query = new BasicDBObject("_id", "jack");
        final DBCursor cursor = collection.find(query);
        System.out.println(cursor.one());

        /**
         * Always shut down connection when application finishes running.
         */
        client.close();
    }
}
