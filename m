Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF2210E6;
	Sat, 13 Jan 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IcjNV4gE"
Received: from localhost.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2D59540755C7;
	Sat, 13 Jan 2024 12:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2D59540755C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705148172;
	bh=EFLq5SwB1lpeS8irlCEfCM3yljqBF66A4Htq4s8Jbwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcjNV4gEYD4c1PhlXXPgCA9F+AI/IRDzgOkqCAgb01Zj4HpQDzQJrOvTZMNoc0V8z
	 FkicwgCCKq4hgE1/er5sUzNdZ7Ww4bSfRbJUyDoOqkkyErpZG2bYPW1XmnhiIAvzOM
	 1bUJQ/OhjzOP/NMKEnXlKthB2AUPRm1/Beh3qqfQ=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: John Johansen <john.johansen@canonical.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 1/2] apparmor: rename the data start flag inside verify_header
Date: Sat, 13 Jan 2024 15:15:51 +0300
Message-ID: <20240113121556.12948-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113121556.12948-1-pchelkin@ispras.ru>
References: <20240113121556.12948-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current `required` flag indicates the packed data start thus requiring
the header to be unpacked at this position.

For the purposes of verify_header() refinement, rename that flag to
`start` so that it can be used with this meaning in other part of the
function.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 security/apparmor/policy_unpack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index a91b30100b77..54f7b4346506 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1111,12 +1111,12 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 /**
  * verify_header - unpack serialized stream header
  * @e: serialized data read head (NOT NULL)
- * @required: whether the header is required or optional
+ * @start: whether the header is located at the start of data
  * @ns: Returns - namespace if one is specified else NULL (NOT NULL)
  *
  * Returns: error or 0 if header is good
  */
-static int verify_header(struct aa_ext *e, int required, const char **ns)
+static int verify_header(struct aa_ext *e, int start, const char **ns)
 {
 	int error = -EPROTONOSUPPORT;
 	const char *name = NULL;
@@ -1124,7 +1124,8 @@ static int verify_header(struct aa_ext *e, int required, const char **ns)
 
 	/* get the interface version */
 	if (!aa_unpack_u32(e, &e->version, "version")) {
-		if (required) {
+		/* the header is required at the start of data */
+		if (start) {
 			audit_iface(NULL, NULL, NULL, "invalid profile format",
 				    e, error);
 			return error;
-- 
2.43.0

