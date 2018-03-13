From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 14 Mar 2018 01:42:24 +0800
Subject: [RFC PATCH linux-next] evm: evm_hmac can be static
In-Reply-To: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
References: <201803140150.bfjQDiL5%fengguang.wu@intel.com>
Message-ID: <20180313174224.GA28779@intel17>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Fixes: c49fc264be98 ("evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 evm_crypto.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index fdde9cb..a46fba3 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -37,8 +37,8 @@ static DEFINE_MUTEX(mutex);
 
 static unsigned long evm_set_key_flags;
 
-char * const evm_hmac = "hmac(sha1)";
-char * const evm_hash = "sha1";
+static char * const evm_hmac = "hmac(sha1)";
+static char * const evm_hash = "sha1";
 
 /**
  * evm_set_key() - set EVM HMAC key from the kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
