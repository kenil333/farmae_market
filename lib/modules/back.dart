import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../all.dart';

class Back with ChangeNotifier {
  final dbref = FirebaseDatabase.instance.reference();
  final dbstore = FirebaseStorage.instance.ref();
  Me? me;

  void addMarked(
    String name,
    String street,
    String city,
    String postcode,
    String country,
    Function navigate,
    Function notdone,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .orderByChild('Name')
        .equalTo(name)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) async {
        if (snap.value == null) {
          await dbref.child('Marked').push().set(
            {
              'AddedBy': me!.phone,
              'Name': name,
              'Street': street,
              'City': city,
              'PostCode': postcode,
              'Country': country,
              'CommitionFee': '4',
            },
          ).catchError(
            (error) {
              err(error.toString());
            },
          ).then((_) {
            navigate();
          });
        } else {
          notdone();
        }
      },
    );
  }

  void setdatesallers(
    String id,
    String sellers,
    String date,
    String day,
    Function done,
    Function err,
  ) async {
    await dbref.child('Marked').child(id).child('DateSeller').child(date).set(
      {
        'Sellers': sellers,
        'Day': day,
      },
    ).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void removedateseller(
    String id,
    String dateid,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .child(id)
        .child('DateSeller')
        .child(dateid)
        .remove()
        .catchError((error) {
      err(error.toString());
    });
  }

  void fetchcategory(
    String name,
    String from,
    Function done,
    Function err,
  ) async {
    List<String> _category = [];
    if (from == 'Category') {
      _category.add('New Category');
    }
    await dbref.child('Categories').once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value == null) {
          done(_category);
        } else {
          snap.value.forEach(
            (key, value) {
              if (name != value['Name']) {
                _category.add(value['Name']);
              }
            },
          );
          done(_category);
        }
      },
    );
  }

  void addcategory(
    String id,
    String name,
    String parent,
    Function done,
    Function err,
  ) async {
    bool _allow = true;
    String? _id;
    await dbref
        .child('Categories')
        .orderByChild('Name')
        .equalTo(name)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          _allow = false;
          snap.value.forEach((ck, cv) {
            _id = ck;
          });
        }
      },
    ).then(
      (_) async {
        if (_allow) {
          await dbref.child('Categories').push().set(
            {
              'Name': name,
              'Parent': parent,
            },
          ).catchError((error) {
            err(error.toString());
          }).then((_) async {
            await dbref
                .child('Categories')
                .orderByChild('Name')
                .equalTo(name)
                .once()
                .catchError((error) {
              err(error.toString());
            }).then(
              (DataSnapshot forid) async {
                if (forid.value != null) {
                  String? cateid;
                  forid.value.forEach((key, value) {
                    cateid = key;
                  });
                  await dbref
                      .child('Marked')
                      .child(id)
                      .child('Categories')
                      .push()
                      .set({
                    'Id': cateid,
                    'Name': name,
                  }).catchError((error) {
                    err(error.toString());
                  }).then((_) {
                    done();
                  });
                }
              },
            );
          });
        } else {
          await dbref.child('Marked').child(id).child('Categories').push().set({
            'Id': _id,
            'Name': name,
          }).catchError((error) {
            err(error.toString());
          }).then((_) {
            done();
          });
        }
      },
    );
  }

  void updatecategory(
    String categoryid,
    String name,
    String parent,
    Function done,
    Function err,
  ) async {
    await dbref.child('Categories').child(categoryid).update(
      {
        'Name': name,
        'Parent': parent,
      },
    ).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void fetchtearms(
    String id,
    String tearmtitle,
    Function done,
    Function stop,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .child(id)
        .child(tearmtitle)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          String term = snap.value;
          done(term);
        } else {
          stop();
        }
      },
    );
  }

  void settearms(
    String id,
    String tearmtitle,
    String teatmtext,
    Function done,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .child(id)
        .child(tearmtitle)
        .set(teatmtext)
        .catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void joinfreescreenfetch(
    String id,
    Function done,
    Function err,
  ) async {
    bool _free = true;
    String _tearm = '';
    await dbref
        .child('Marked')
        .child(id)
        .child('FreeToJoin')
        .once()
        .catchError((error) {
      err(error.toString());
    }).then((DataSnapshot joinsnap) {
      if (joinsnap.value != null) {
        _free = joinsnap.value;
      }
    }).then((_) async {
      await dbref
          .child('Marked')
          .child(id)
          .child('AdminText')
          .once()
          .catchError((error) {
        err(error.toString());
      }).then((DataSnapshot adminsnap) {
        if (adminsnap.value != null) {
          _tearm = adminsnap.value;
          done(_free, _tearm);
        } else {
          done(_free, _tearm);
        }
      });
    });
  }

  void setjoinfreescreen(
    String id,
    bool free,
    String admintext,
    Function done,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .child(id)
        .child('FreeToJoin')
        .set(free)
        .catchError((error) {
      err(error.toString());
    }).then((_) async {
      await dbref
          .child('Marked')
          .child(id)
          .child('AdminText')
          .set(admintext)
          .catchError((error) {
        err(error.toString());
      }).then((_) {
        done();
      });
    });
  }

  void fetchapptearm(
    String tearmtitle,
    Function done,
    Function err,
  ) async {
    String _tearm = '';
    await dbref.child(tearmtitle).once().catchError((error) {
      err(error.toString());
    }).then((DataSnapshot snap) {
      if (snap.value != null) {
        _tearm = snap.value;
        done(_tearm);
      } else {
        done(_tearm);
      }
    });
  }

  void apptearms(
    String tearmtitle,
    String tearm,
    Function done,
    Function err,
  ) async {
    await dbref.child(tearmtitle).set(tearm).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void checkmobile(
    String phone,
    Function done,
    Function notdone,
    Function err,
  ) async {
    dbref.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then((DataSnapshot snap) {
      if (snap.value == null) {
        done();
      } else {
        notdone();
      }
    });
  }

  void sellerregister(
    String phone,
    String company,
    String org,
    String email,
    String password,
    String street,
    String city,
    String postcode,
    Function done,
    Function notdone,
    Function err,
  ) async {
    bool _error = false;
    await dbref.child('Users').child(phone).set({
      'CompanyName': company,
      'OrgNo': org,
      'Email-Id': email,
      'Password': password,
      'Street': street,
      'City': city,
      'PostCode': postcode,
      'Who': ConstantValue().seller,
      'Block': false,
    }).catchError((error) {
      err(error.toString());
      _error = true;
    }).then((_) {
      if (_error) {
        notdone();
      } else {
        done();
      }
    });
  }

  void autologin(
    Function custlogin,
    Function sellogin,
    Function nologin,
    Function err,
  ) async {
    bool _error = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _phone = prefs.getString('Phone') ?? 'Phone';
    String _password = prefs.getString('Password') ?? 'Password';
    if (_phone == 'Phone' || _password == 'Password') {
      nologin();
    } else {
      await dbref.child('Users').child(_phone).once().catchError((error) {
        err(error.toString());
        _error = true;
      }).then((DataSnapshot snap) {
        if (_error) {
          nologin();
        } else {
          if (snap.value == null) {
            nologin();
          } else {
            if (snap.value['Password'] == _password &&
                snap.value['Block'] == false) {
              if (snap.value['Who'] == ConstantValue().customer) {
                me = Me(
                  phone: snap.key ?? 'NoPhone',
                  name: snap.value['CompanyName'],
                  email: snap.value['Email-Id'],
                  who: snap.value['Who'],
                );
                notifyListeners();
                custlogin();
              } else {
                me = Me(
                  phone: snap.key ?? 'NoPhone',
                  name: snap.value['CompanyName'],
                  email: snap.value['Email-Id'],
                  who: snap.value['Who'],
                );
                notifyListeners();
                sellogin();
              }
            } else {
              nologin();
            }
          }
        }
      });
    }
  }

  void logout(Function navigate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Phone', 'Phone').then(
      (_) async {
        await prefs.setString('Password', 'Password').then(
          (_) {
            navigate();
          },
        );
      },
    );
  }

  void sellerlogin(
    String phone,
    String password,
    Function done,
    Function notdone,
    Function nophone,
    Function nopassword,
    Function noallowed,
    Function noseller,
    Function err,
  ) async {
    bool _error = false;
    await dbref.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
      _error = true;
    }).then((DataSnapshot snap) async {
      if (_error) {
        notdone();
      } else {
        if (snap.value == null) {
          nophone();
        } else {
          if (snap.value['Who'] == ConstantValue().customer) {
            noseller();
          } else {
            if (snap.value['Password'] != password) {
              nopassword();
            } else {
              if (snap.value['Block'] == true) {
                noallowed();
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('Phone', phone).then(
                  (_) async {
                    await prefs.setString('Password', password).then(
                      (_) {
                        me = Me(
                          phone: snap.key ?? 'NoPhone',
                          name: snap.value['CompanyName'],
                          email: snap.value['Email-Id'],
                          who: snap.value['Who'],
                        );
                        notifyListeners();
                        done();
                      },
                    );
                  },
                );
              }
            }
          }
        }
      }
    });
  }

  void changepass(
    String phone,
    String pass,
    Function done,
    Function notdone,
    Function err,
  ) async {
    bool _error = false;
    await dbref
        .child('Users')
        .child(phone)
        .child('Password')
        .set(pass)
        .catchError((error) {
      err(error.toString());
      _error = true;
    }).then((_) {
      if (_error) {
        notdone();
      } else {
        done();
      }
    });
  }

  void custregister(
    String phone,
    String company,
    String email,
    String pass,
    String street,
    String city,
    String postcode,
    Function done,
    Function notdone,
    Function err,
  ) async {
    bool _error = false;
    await dbref.child('Users').child(phone).set({
      'CompanyName': company,
      'Email-Id': email,
      'Password': pass,
      'Street': street,
      'City': city,
      'PostCode': postcode,
      'Who': ConstantValue().customer,
      'Block': false,
    }).catchError((error) {
      err(error.toString());
      _error = true;
    }).then((_) {
      if (_error) {
        notdone();
      } else {
        done();
      }
    });
  }

  void custlogin(
    String phone,
    String password,
    Function done,
    Function notdone,
    Function nophone,
    Function nopassword,
    Function noallowed,
    Function noseller,
    Function err,
  ) async {
    bool _error = false;
    await dbref.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
      _error = true;
    }).then((DataSnapshot snap) async {
      if (_error) {
        notdone();
      } else {
        if (snap.value == null) {
          nophone();
        } else {
          if (snap.value['Who'] != ConstantValue().customer) {
            noseller();
          } else {
            if (snap.value['Password'] != password) {
              nopassword();
            } else {
              if (snap.value['Block'] == true) {
                noallowed();
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('Phone', phone).then(
                  (_) async {
                    await prefs.setString('Password', password).then(
                      (_) {
                        me = Me(
                          phone: snap.key ?? 'NoPhone',
                          name: snap.value['CompanyName'],
                          email: snap.value['Email-Id'],
                          who: snap.value['Who'],
                        );
                        notifyListeners();
                        done();
                      },
                    );
                  },
                );
              }
            }
          }
        }
      }
    });
  }

  void addadmin(
    String id,
    String phone,
    String company,
    String email,
    String pass,
    //String who,
    Function done,
    Function notdone,
    Function err,
  ) async {
    await dbref.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) async {
        if (snap.value != null) {
          notdone();
        } else {
          await dbref.child('Users').child(phone).set(
            {
              'CompanyName': company,
              'Email-Id': email,
              'Password': pass,
              'Who': ConstantValue().admin,
              'Block': false,
            },
          ).catchError((error) {
            err(error.toString());
          }).then((_) async {
            await dbref
                .child('Marked')
                .child(id)
                .child('Admins')
                .push()
                .set(phone)
                .catchError((error) {
              err(error.toString());
            }).then((_) {
              done();
            });
          });
        }
      },
    );
  }

  void updateadmin(
    String phone,
    String company,
    String email,
    String pass,
    //String who,
    Function done,
    Function err,
  ) async {
    await dbref.child('Users').child(phone).update(
      {
        'CompanyName': company,
        'Email-Id': email,
        'Password': pass,
        //'Who': who,
        // 'Block': false,
      },
    ).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void pickimage(Function doany) async {
    final _pick = await ImagePicker().pickImage(source: ImageSource.gallery);
    doany(_pick);
  }

  Future<void> uploadandget(
    String id,
    File? image,
    Function func,
    Function err,
  ) async {
    bool _error = false;
    final ref = dbstore.child('Product').child('$id.jpg');
    await ref.putFile(image!).catchError((error) {
      err(error.toString());
      _error = true;
    }).then((_) async {
      String url = await ref.getDownloadURL();
      func(url, _error);
    });
  }

  void addproduct(
    String phone,
    String productid,
    File? image,
    String name,
    String price,
    String available,
    String tax,
    String unitvalue,
    String unit,
    String tempzone,
    String category,
    String description,
    String expiry,
    Function done,
    Function notdone,
    Function somewrong,
    Function err,
  ) async {
    bool _error = false;
    String _url = 'No URL';
    await dbref.child('Product').child(productid).once().catchError((error) {
      err(error.toString());
      _error = true;
    }).then(
      (DataSnapshot snap) async {
        if (_error) {
          somewrong();
        } else {
          if (snap.value == null) {
            await uploadandget(
              productid,
              image,
              (String url, bool error) {
                _url = url;
                _error = error;
              },
              err,
            ).then(
              (_) async {
                if (_error) {
                  somewrong();
                } else {
                  await dbref.child('Product').child(productid).set(
                    {
                      'AddedBy': phone,
                      'Image-URL': _url,
                      'Name': name,
                      'Price': price,
                      'Available': available,
                      'Tax': tax,
                      'Unit-Value': unitvalue,
                      'Unit': unit,
                      'Temp-Zone': tempzone,
                      'Category': category,
                      'Description': description,
                      'Expiry': expiry,
                    },
                  ).catchError((error) {
                    err(error.toString());
                    _error = true;
                  }).then(
                    (_) async {
                      if (_error) {
                        somewrong();
                      } else {
                        done();
                        // await dbref
                        //     .child('Users')
                        //     .child(phone)
                        //     .child('Product')
                        //     .push()
                        //     .set(productid)
                        //     .catchError((error) {
                        //   err(error.toString());
                        //   _error = true;
                        // }).then(
                        //   (_) {
                        //     if (_error) {
                        //       somewrong();
                        //     } else {
                        //       done();
                        //     }
                        //   },
                        // );
                      }
                    },
                  );
                }
              },
            );
          } else {
            notdone();
          }
        }
      },
    );
  }

  void updateproduct(
    String productid,
    String imageurl,
    File? image,
    String name,
    String price,
    String available,
    String tax,
    String unitvalue,
    String unit,
    String tempzone,
    String category,
    String description,
    String expiry,
    Function done,
    Function somewrong,
    Function err,
  ) async {
    bool _error = false;
    String _url = 'No URL';
    if (image == null) {
      await dbref.child('Product').child(productid).update(
        {
          'Image-URL': imageurl,
          'Name': name,
          'Price': price,
          'Available': available,
          'Tax': tax,
          'Unit-Value': unitvalue,
          'Unit': unit,
          'Temp-Zone': tempzone,
          'Category': category,
          'Description': description,
          'Expiry': expiry,
        },
      ).catchError((error) {
        err(error.toString());
        _error = true;
      }).then(
        (_) {
          if (_error) {
            somewrong();
          } else {
            done();
          }
        },
      );
    } else {
      await uploadandget(
        productid,
        image,
        (String url, bool error) {
          _url = url;
          _error = error;
        },
        err,
      ).then((_) async {
        if (_error) {
          somewrong();
        } else {
          await dbref.child('Product').child(productid).update(
            {
              'Image-URL': _url,
              'Name': name,
              'Price': price,
              'Available': available,
              'Tax': tax,
              'Unit-Value': unitvalue,
              'Unit': unit,
              'Temp-Zone': tempzone,
              'Category': category,
              'Description': description,
              'Expiry': expiry,
            },
          ).catchError((error) {
            err(error.toString());
            _error = true;
          }).then(
            (_) {
              if (_error) {
                somewrong();
              } else {
                done();
              }
            },
          );
        }
      });
    }
  }

  void deliverapplifree(
    String id,
    String date,
    int totsel,
    String sellerid,
    String applitext,
    Function done,
    Function notdone,
    Function err,
  ) async {
    int _count = 0;
    await dbref
        .child('Marked')
        .child(id)
        .child('Sellers')
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          List<String> _se = [];
          snap.value.forEach(
            (key, val) {
              _se.add(key);
            },
          );
          _count = _se.length;
        }
      },
    ).then((_) async {
      if (totsel > _count) {
        await dbref
            .child('Marked')
            .child(id)
            .child('Sellers')
            .child(sellerid)
            .set(
          {
            'Application-Text': applitext,
            'Block': false,
            'Dates': {
              date: {
                'Join': true,
                'Invoice': false,
              },
            },
          },
        ).catchError((error) {
          err(error.toString());
        }).then((_) {
          done();
        });
      } else {
        notdone();
      }
    });
  }

  void joinsetdate(
    String id,
    String sellerid,
    String date,
    Function done,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .child(id)
        .child('Sellers')
        .child(sellerid)
        .child('Dates')
        .child(date)
        .set(true)
        .catchError((error) {
      err(error.toString());
    }).then(
      (_) {
        done();
      },
    );
  }

  void fetchSellCust(
    List<String> sellid,
    Function done,
    Function err,
  ) async {
    List<SellerCust> _sellers = [];
    await dbref
        .child('Users')
        .orderByChild('Who')
        .equalTo(ConstantValue().seller)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          snap.value.forEach(
            (key, value) {
              if (sellid.contains(key)) {
                _sellers.add(
                  SellerCust(
                    phone: key,
                    company: value['CompanyName'],
                  ),
                );
              }
            },
          );
          done(_sellers);
        }
      },
    );
  }

  List<CustProd> _sellerprod = [];

  void fetchprodcust(
    String id,
    Function done,
    Function notdone,
    Function err,
  ) async {
    List<CustProd> _prod = [];
    await dbref
        .child('Product')
        .orderByChild('AddedBy')
        .equalTo(id)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          snap.value.forEach(
            (key, value) {
              if (int.parse(value['Available']) > 0) {
                _prod.add(
                  CustProd(
                    id: key,
                    image: value['Image-URL'],
                    name: value['Name'],
                    price: double.parse(value['Price']),
                    available: int.parse(value['Available']),
                    description: value['Description'],
                    unit: value['Unit'],
                    qty: int.parse(value['Unit-Value']),
                    tax: int.parse(value['Tax']),
                  ),
                );
              }
            },
          );
          _sellerprod = _prod;
          notifyListeners();
          done(_prod);
        } else {
          notdone();
        }
      },
    );
  }

  void addorremovecart(
    String custid,
    String sellid,
    String prodid,
    double price,
    int count,
    bool add,
  ) async {
    if (!add && count == 1) {
      await dbref
          .child('Cart')
          .child(custid)
          .child(sellid)
          .child(prodid)
          .remove();
    } else {
      await dbref.child('Cart').child(custid).child(sellid).child(prodid).set(
        {
          'Count': add ? count + 1 : count - 1,
          'Price': add
              ? ((count + 1) * price).toStringAsFixed(2)
              : ((count - 1) * price).toStringAsFixed(2),
        },
      );
    }
  }

  CustProd singleprod(String id) {
    int _i = _sellerprod.indexWhere((e) => e.id == id);
    return _sellerprod[_i];
  }

  int gettax(String id) {
    int i = _sellerprod.indexWhere((e) => e.id == id);
    return _sellerprod[i].tax;
  }

  void allowtoorder(
    List<CartProd> cartptod,
    Function done,
    Function notdone,
  ) {
    List<AllowOrder> _iteam = [];
    String forPrint = '';
    for (int i = 0; i < cartptod.length; i++) {
      int _i =
          _sellerprod.indexWhere((element) => element.id == cartptod[i].id);
      if (cartptod[i].count > _sellerprod[_i].available) {
        _iteam.add(
          AllowOrder(
            name: _sellerprod[_i].name,
            count: _sellerprod[_i].available,
          ),
        );
      }
    }
    if (_iteam.isEmpty) {
      done();
    } else {
      for (int i = 0; i < _iteam.length; i++) {
        if (i == _iteam.length - 1 && _iteam.length == 1) {
          forPrint += '${_iteam[i].count} - ${_iteam[i].name}';
        } else if (i == _iteam.length - 1) {
          forPrint += '${_iteam[i].count} - ${_iteam[i].name} ';
        } else {
          forPrint += '${_iteam[i].count} - ${_iteam[i].name}, ';
        }
      }
      notdone(forPrint);
    }
  }

  void order(
    String total,
    String subtotal,
    OnlyOneMarkedCust marked,
    SellerCust seller,
    List<OrderProd> prod,
    Function done,
    Function notdone,
    Function err,
  ) async {
    List<AllowOrder> _iteam = [];
    String forPrint = '';
    for (int i = 0; i < prod.length; i++) {
      await dbref
          .child('Product')
          .child(prod[i].id)
          .child('Available')
          .once()
          .catchError((error) {
        err(error.toString());
      }).then(
        (DataSnapshot prosnap) {
          prod[i].available = int.parse(prosnap.value);
          if (prod[i].count > prod[i].available) {
            _iteam.add(
              AllowOrder(
                name: prod[i].name,
                count: prod[i].available,
              ),
            );
          }
        },
      );
    }

    if (_iteam.isNotEmpty) {
      for (int i = 0; i < _iteam.length; i++) {
        if (i == _iteam.length - 1 && _iteam.length == 1) {
          forPrint += '${_iteam[i].count} - ${_iteam[i].name}';
        } else if (i == _iteam.length - 1) {
          forPrint += '${_iteam[i].count} - ${_iteam[i].name} ';
        } else {
          forPrint += '${_iteam[i].count} - ${_iteam[i].name}, ';
        }
      }
      notdone(forPrint);
    } else {
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
      Random _rnd = Random();
      String safeword = String.fromCharCodes(
        Iterable.generate(
          5,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
      int _ordercount = 0;
      await dbref.child('OrderCount').once().catchError((error) {
        err(error.toString());
      }).then(
        (DataSnapshot countsnap) async {
          if (countsnap.value != null) {
            _ordercount = countsnap.value;
          }
          await dbref.child('Orders').push().set(
            {
              'ID': (_ordercount + 1).toString(),
              'Safeword': safeword,
              'Total': total,
              'SubTotal': subtotal,
              'CustomerConfirm': 'Just Order',
              'SellerConfirm': 'Just Order',
              'C-ID': me!.phone,
              'C-Name': me!.name,
              'M-ID': marked.id,
              'M-Name': marked.name,
              'M-Date': DateFormat('yyyyMMdd').format(marked.date),
              'M-Day': marked.day,
              'M-Street': marked.street,
              'M-postcode': marked.postcode,
              'M-City': marked.city,
              'S-Phone': seller.phone,
              'S-Name': seller.company,
              'S-Logo': 'Seller Logo',
              'Products': prod
                  .map(
                    (e) => {
                      'P-ID': e.id,
                      'P-Name': e.name,
                      'P-Image': e.image,
                      'P-Price': e.price.toStringAsFixed(2),
                      'P-Total': e.total.toStringAsFixed(2),
                      'P-QTY': e.qty.toString(),
                      'P-Unit': e.unit,
                      'P-Tax': e.tax.toString(),
                      'P-TaxPrice': e.taxprice.toStringAsFixed(2),
                      'P-Count': e.count.toString(),
                    },
                  )
                  .toList(),
            },
          ).catchError((error) {
            err(error.toString());
          }).then(
            (_) async {
              await dbref
                  .child('OrderCount')
                  .set(_ordercount + 1)
                  .catchError((error) {
                err(error.toString());
              }).then((_) {
                prod.forEach(
                  (element) async {
                    await dbref
                        .child('Product')
                        .child(element.id)
                        .child('Available')
                        .set((element.available - element.count).toString())
                        .catchError((error) {
                      err(error.toString());
                    });
                  },
                );
              }).then(
                (_) async {
                  await dbref
                      .child('Cart')
                      .child(me!.phone)
                      .child(seller.phone)
                      .remove()
                      .then((_) {
                    done(_ordercount + 1);
                  });
                },
              );
            },
          );
        },
      );
    }
  }

  void commingorconfirm(
    String id,
    String forwho,
    String value,
    Function done,
    Function err,
  ) async {
    await dbref
        .child('Orders')
        .child(id)
        .child(forwho)
        .set(value)
        .catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void ownercommition(
    String commition,
    Function done,
    Function err,
  ) async {
    await dbref.child('Commision').set(commition).catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void sellerforowner(
    String who,
    String orderby,
    Function done,
    Function notdone,
    Function err,
  ) async {
    List<SellerInOwner> _seller = [];
    await dbref
        .child('Users')
        .orderByChild('Who')
        .equalTo(who)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot selsnap) async {
        if (selsnap.value != null) {
          await selsnap.value.forEach(
            (key, value) async {
              await dbref
                  .child('Orders')
                  .orderByChild(orderby)
                  .equalTo(key)
                  .once()
                  .catchError((error) {
                err(error.toString());
              }).then(
                (DataSnapshot totsnap) async {
                  if (totsnap.value != null) {
                    double _total = 0;
                    List<MarkedInSelOwner> _marked = [];
                    await totsnap.value.forEach(
                      (ke, val) {
                        _total += double.parse(val['Total']);
                        if (_marked.isEmpty) {
                          _marked.add(
                            MarkedInSelOwner(
                              name: val['M-Name'],
                              street: val['M-Street'],
                              postcode: val['M-postcode'],
                              city: val['M-City'],
                              day: val['M-Day'],
                              date: DateTime.parse(val['M-Date']),
                            ),
                          );
                        } else {
                          bool _found = _marked.any(
                            (element) =>
                                element.name == val['M-Name'] &&
                                element.date == DateTime.parse(val['M-Date']),
                          );
                          if (!_found) {
                            _marked.add(
                              MarkedInSelOwner(
                                name: val['M-Name'],
                                street: val['M-Street'],
                                postcode: val['M-postcode'],
                                city: val['M-City'],
                                day: val['M-Day'],
                                date: DateTime.parse(val['M-Date']),
                              ),
                            );
                          }
                        }
                      },
                    );
                    _seller.add(
                      SellerInOwner(
                        phone: key,
                        company: value['CompanyName'],
                        org: value['OrgNo'] ?? 'OrgNo',
                        email: value['Email-Id'],
                        password: value['Password'],
                        street: value['Street'],
                        city: value['City'],
                        postcode: value['PostCode'],
                        total: _total,
                        marked: _marked,
                      ),
                    );
                  }
                },
              );
            },
          );
          done(_seller);
        } else {
          notdone();
        }
      },
    );
  }

  void updateselcust(
    String phone,
    String company,
    String org,
    String email,
    String street,
    String city,
    String postcode,
    bool seller,
    Function done,
    Function err,
  ) async {
    await dbref
        .child('Users')
        .child(phone)
        .update(
          seller
              ? {
                  'CompanyName': company,
                  'OrgNo': org,
                  'Email-Id': email,
                  'Street': street,
                  'City': city,
                  'PostCode': postcode,
                }
              : {
                  'CompanyName': company,
                  'Email-Id': email,
                  'Street': street,
                  'City': city,
                  'PostCode': postcode,
                },
        )
        .catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void blockunblock(
    String phone,
    bool value,
    Function done,
    Function err,
  ) async {
    await dbref
        .child('Users')
        .child(phone)
        .child('Block')
        .set(value)
        .catchError((error) {
      err(error.toString());
    }).then((_) {
      done();
    });
  }

  void salandincom(
    String id,
    Function done,
    Function notdone,
    Function err,
  ) async {
    await dbref
        .child('Orders')
        .orderByChild('M-ID')
        .equalTo(id)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          List<String> _sels = [];
          double _income = 0;
          snap.value.forEach(
            (key, value) {
              _sels.add(key);
              _income += double.parse(value['Total']);
            },
          );
          done(_sels.length, _income);
        } else {
          notdone();
        }
      },
    );
  }

  void comitionfetch(
    Function done,
    Function err,
  ) async {
    List<MarkedInCommistion> _marked = [];
    await dbref.child('Marked').once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot markedsnap) {
        if (markedsnap.value != null) {
          markedsnap.value.forEach(
            (key, value) {
              if (value['DateSeller'] != null) {
                value['DateSeller'].forEach(
                  (dkey, dvalue) {
                    List<OnlyForComSel> _sel = [];
                    if (value['Sellers'] != null) {
                      value['Sellers'].forEach(
                        (skey, svalue) {
                          if (svalue['Dates'] != null) {
                            svalue['Dates'].forEach(
                              (sdkey, sdvalue) {
                                if (dkey == sdkey) {
                                  _sel.add(
                                    OnlyForComSel(
                                      phone: skey,
                                      invoice: sdvalue['Invoice'],
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                      );
                    }
                    _marked.add(
                      MarkedInCommistion(
                        id: key,
                        name: value['Name'],
                        day: dvalue['Day'],
                        date: DateTime.parse(dkey),
                        street: value['Street'],
                        city: value['City'],
                        postcode: value['PostCode'],
                        sel: _sel,
                      ),
                    );
                  },
                );
              }
            },
          );
          if (_marked.length > 1) {
            _marked.sort(
              (a, b) {
                return b.date.compareTo(a.date);
              },
            );
          }
          done(_marked);
        } else {
          done(_marked);
        }
      },
    );
  }

  void markedkamani(
    String id,
    DateTime date,
    Function done,
    Function notdone,
    Function err,
  ) async {
    await dbref
        .child('Orders')
        .orderByChild('M-ID')
        .equalTo(id)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          List<SellerInOwnerCommition> _seller = [];
          double _tot = 0;
          snap.value.forEach(
            (key, value) async {
              if (DateTime.parse(value['M-Date']) == date) {
                _tot += double.parse(value['Total']);
                if (_seller.any(
                  (e) => e.phone == value['S-Phone'],
                )) {
                  int i = _seller.indexWhere(
                    (element) => element.phone == value['S-Phone'],
                  );
                  _seller[i].total += double.parse(value['Total']);
                } else {
                  _seller.add(
                    SellerInOwnerCommition(
                      phone: value['S-Phone'],
                      name: value['S-Name'],
                      total: double.parse(value['Total']),
                    ),
                  );
                }
              }
            },
          );
          if (_seller.length > 1) {
            _seller.sort(
              (a, b) {
                return a.total.compareTo(b.total);
              },
            );
          }
          done(_seller, _tot);
        } else {
          notdone();
        }
      },
    );
  }

  void onlyseller(
    String phone,
    Function done,
    Function err,
  ) async {
    await dbref.child('Users').child(phone).once().catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        done(
          snap.value['OrgNo'],
          snap.value['Email-Id'],
          '${snap.value['Street']}, ${snap.value['PostCode']} ${snap.value['City']}',
        );
      },
    );
  }

  void updateinvoice(
    String id,
    String sid,
    String date,
    bool value,
    Function err,
  ) async {
    await dbref
        .child('Marked')
        .child(id)
        .child('Sellers')
        .child(sid)
        .child('Dates')
        .child(date)
        .child('Invoice')
        .set(value)
        .catchError((error) {
      err(error.toString());
    });
  }

  void setupmarkedinfo(
    String id,
    Function done,
    Function notdone,
    Function err,
  ) async {
    await dbref
        .child('Orders')
        .orderByChild('M-ID')
        .equalTo(id)
        .once()
        .catchError((error) {
      err(error.toString());
    }).then(
      (DataSnapshot snap) {
        if (snap.value != null) {
          List<String> _ids = [];
          List<Datewithselandcust> _dates = [];
          snap.value.forEach(
            (key, value) {
              _ids.add(key);
              if (_dates.any(
                (e) =>
                    e.date ==
                    DateTime.parse(
                      value['M-Date'],
                    ),
              )) {
                int i = _dates.indexWhere(
                  (element) =>
                      element.date ==
                      DateTime.parse(
                        value['M-Date'],
                      ),
                );
                if (!_dates[i].seller.contains(
                      value['S-Phone'],
                    )) {
                  _dates[i].seller.add(value['S-Phone']);
                }
                if (!_dates[i].customer.contains(
                      value['C-ID'],
                    )) {
                  _dates[i].customer.add(value['C-ID']);
                }
              } else {
                List<String> _se = [];
                List<String> _ce = [];
                _se.add(value['S-Phone']);
                _ce.add(value['C-ID']);
                _dates.add(
                  Datewithselandcust(
                    date: DateTime.parse(value['M-Date']),
                    day: value['M-Day'],
                    seller: _se,
                    customer: _ce,
                  ),
                );
              }
            },
          );
          done(_ids.length, _dates);
        } else {
          notdone();
        }
      },
    );
  }
}
