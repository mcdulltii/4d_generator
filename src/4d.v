/*

   Copyright 2023 Aaron Ti

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

*/

module main

import os
import vweb
import vweb.sse
import time
import math
import rand
import crypto.aes

__global (
    pass map[string]string
    decrypted string
)

struct App {
    vweb.Context
}

fn main() {
    // Start web server
    mut app := &App{}
    app.mount_static_folder_at(os.resource_abs_path('.'), '/')
    vweb.run(app, 12345)
}

fn compare(a []u8) int {
    // fdaHq3k,MR-pI1C%UZN7%yvX7PrsQZb3
    if a.len == 32 {
        if a[31] == 118 {
            if a[19] == 0 {
                if a[21] == 87 {
                    if a[13] == 19 {
                        if a[30] == 110 {
                            if a[14] == 84 {
                                if a[20] == 63 {
                                    if a[24] == 91 {
                                        if a[12] == 43 {
                                            if a[29] == 22 {
                                                if a[11] == 104 {
                                                    if a[10] == 17 {
                                                        if a[2] == 100 {
                                                            if a[6] == 23 {
                                                                if a[0] == 106 {
                                                                    if a[18] == 40 {
                                                                        if a[27] == 28 {
                                                                            if a[25] == 20 {
                                                                                if a[1] == 1 {
                                                                                    if a[22] == 59 {
                                                                                        if a[17] == 104 {
                                                                                            if a[8] == 117 {
                                                                                                if a[23] == 126 {
                                                                                                    if a[16] == 37 {
                                                                                                        if a[3] == 45 {
                                                                                                            if a[4] == 94 {
                                                                                                                if a[26] == 120 {
                                                                                                                    if a[28] == 87 {
                                                                                                                        if a[15] == 110 {
                                                                                                                            if a[7] == 46 {
                                                                                                                                if a[5] == 96 {
                                                                                                                                    if a[9] == 40 {
                                                                                                                                        return decrypt(a)
                                                                                                                                    }
                                                                                                                                }
                                                                                                                            }
                                                                                                                        }
                                                                                                                    }
                                                                                                                }
                                                                                                            }
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return -1
}

/*
fn (mut app App) encrypt() vweb.Result {
    // Manipulate AES key
    mut a := 'fdaHq3k,MR-pI1C%UZN7%yvX7PrsQZb3'.bytes()
    for i, _ in a {
        a[i] += 5
        a[i] ^= u8(i + 1)
        if i > 0 {
            a[i] ^= a[i-1]
        }
    }

    // AES Initialization
    cipher := aes.new_cipher(a)

    // AES Encryption
    mut data := 'TISC{Vlang_R3v3rs3_3ng1n333r1ng}'.bytes()
    // mut data := 'TISC{THIS_IS_NOT_THE_FLAG_00000}'.bytes()
    // Encrypt 1st block
    mut encrypted := []u8{len: aes.block_size}
    cipher.encrypt(mut encrypted, data[..16])
    // Encrypt 2nd block
    mut encrypted2 := []u8{len: aes.block_size}
    cipher.encrypt(mut encrypted2, data[16..])
    // Join encrypted blocks
    encrypted << encrypted2
    println(encrypted)

    return app.text('$encrypted')
}
*/

fn decrypt(a []u8) int {
    // AES Initialization
    cipher := aes.new_cipher(a)

    // Flag string
    encrypted := [u8(126), 130, 220, 138, 124, 95, 153, 133, 137, 48, 70, 155, 121, 120, 214, 248, 44, 72, 162, 161, 57, 216, 143, 178, 224, 17, 192, 248, 183, 186, 231, 101]
    // Fake string
    // encrypted := [u8(140), 136, 11, 10, 13, 180, 116, 122, 196, 218, 228, 85, 20, 56, 22, 87, 183, 137, 122, 149, 106, 19, 137, 95, 26, 33, 235, 91, 179, 114, 136, 75]

    // AES Decryption
    // Decrypt 1st block
    mut decrypted1 := []u8{len: aes.block_size}
    cipher.decrypt(mut decrypted1, encrypted[..16])
    // Decrypt 2nd block
    mut decrypted2 := []u8{len: aes.block_size}
    cipher.decrypt(mut decrypted2, encrypted[16..])
    // Join decrypted blocks
    decrypted1 << decrypted2
    decrypted = decrypted1.bytestr()

    // Check decryption
    if decrypted.contains('TISC') {
        return 0
    }
    return -1
}

pub fn (mut app App) index() vweb.Result {
    // UUID cookie
    user_id := app.get_cookie('id') or { '0' }
    // Generate cookie if not exists
    each := pass[user_id] or { '0' }
    if user_id == '0' || each == '0' {
        uuid := rand.uuid_v4()
        pass[uuid] = ''
        app.set_cookie(name: 'id', value: uuid)
    }

    title := '4D Number Generator'
    return $vweb.html()
}

fn (mut app App) get_4d_number() vweb.Result {
    mut session := sse.new_connection(app.conn)
    session.start() or { return app.server_error(501) }
    session.send_message(data: 'ok') or { return app.server_error(501) }

    // Generate number based on UUID cookie
    user_id := app.get_cookie('id') or { return app.server_error(501) }
    val := pass[user_id] or { return app.server_error(501) }
    mut each := val.bytes()

    for _ in 0..5 {
        // Generate 4D number
        mut num := [u8(math.abs(rand.int() % 10)),
                    u8(math.abs(rand.int() % 10)),
                    u8(math.abs(rand.int() % 10)),
                    u8(math.abs(rand.int() % 10))]

        // Manipulate input
        for _ in 0..8 {
            each << num
        }
        each = each[0..32]
        for i, _ in each {
            each[i] += 5
            each[i] ^= u8(i + 1)
            if i > 0 {
                each[i] ^= each[i-1]
            }
        }
        pass[user_id] = each.str()

        cmp_rtn := compare(each)
        // Send data
        num_str := num.map(it.str()).join('')
        mut data := ''
        if cmp_rtn == -1 {
            data = '{"number": "${num_str}"}'
        } else {
            data = '{"number": "${decrypted}"}'
        }
        session.send_message(event: 'ping', data: data) or { return app.server_error(501) }
        println('> Sent data: ${data}')
        time.sleep(100 * time.millisecond)
    }

    session.send_message(data: 'ok') or { return app.server_error(501) }
    return app.ok('ok')
}

['/:inpt'; post]
fn (mut app App) handle_inpt(inpt string) vweb.Result {
    user_id := app.get_cookie('id') or { '0' }
    // Save POST string by UUID cookie
    each := pass[user_id] or { '0' }
    if user_id != '0' && each != '0' {
        pass[user_id] = inpt
    }
    return app.text('Received $inpt!')
}
