From: ebiggers3@gmail.com (Eric Biggers)
Date: Thu, 21 Sep 2017 13:57:39 -0700
Subject: [PATCH v2 0/3] KEYS: fix error handling in request_key_auth_new()
Message-ID: <20170921205742.144596-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix a reference leak and a NULL pointer dereference in the error
handling paths of request_key_auth_new().

Eric Biggers (3):
  KEYS: fix cred refcount leak in request_key_auth_new()
  KEYS: don't revoke uninstantiated key in request_key_auth_new()
  KEYS: use kmemdup() in request_key_auth_new()

 security/keys/request_key_auth.c | 73 ++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

-- 
2.14.1.821.g8fa685d3b7-goog

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
