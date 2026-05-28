Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D569305697
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937803; cv=none; b=bipg5nd7JCSFO/oGbkW11B2EfGTdLrGqghyYzH6f/ovYJ2TkbrVCJFBH4RcK1liCIH+D9OHN3WWfocIYwW9AzC08g9Rc6W3T1bGxb7nDIlrstFKvOYstJye9Y4y9+K1YbmUHIEok+YO+GozA7tQfIbe5rnknZLmBTXOuYMBkQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937803; c=relaxed/simple;
	bh=FEt+NH+bchS8fZaePik62xraJ9IciAo9xRxq7s98cZ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atx7lcz2PpcwGm3qdVJ9szoimI0imth52xEcuFDBQClXrgASP9psAvO24cDCIE3xdDwcuQ8BkcTb78gp1J2RCju31sjRr2RY/QgZSwpXR/kONy63PptsW2BXYDWh1I3vM2Dh45CGOkCUrxwHQSHJGsU+Ct3IYYAi2gJfdZi8YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I+B9DrRe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I+B9DrRe"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A9EC20B7168;
	Wed, 27 May 2026 20:09:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A9EC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937789;
	bh=lSUCTsBi/bMNjXv3HdvWYiA9/LGwo/AD/LH7RZrtV0Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I+B9DrReIK8qEaGUUpS3DLmtL4CTIzH6j3J+94GNXbGueETB0dQVLA5vDTFF++UBV
	 zmwRmlwkQM8qHx6FKTvyXK2QTk2JbTp1LIUYx0dP/2DEJKGHo9BoBPlNCmxDC5FVUX
	 I4LI6fU9E1rs7n/pIsie62UjRtcdXOmhjvn/FY6w=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric Biggers" <ebiggers@kernel.org>,
	"Fan Wu" <wufan@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 11/11] hornet: scripts: Improve argument handling and error messages
Date: Wed, 27 May 2026 20:08:20 -0700
Message-ID: <20260528030915.2654994-12-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spaces in file names may have caused invocation errors. Additionally
add helpful error messages if we are unable to extract the requested
payload.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/extract-insn.sh | 14 +++++++++++---
 scripts/hornet/extract-map.sh  | 15 ++++++++++++---
 scripts/hornet/extract-skel.sh | 25 ++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/scripts/hornet/extract-insn.sh b/scripts/hornet/extract-insn.sh
index 3e7bed049acb6..e0c7a4ae967f3 100755
--- a/scripts/hornet/extract-insn.sh
+++ b/scripts/hornet/extract-insn.sh
@@ -21,7 +21,15 @@ EXPECTED_ARGS=1
 
 if [ $ARGC -ne $EXPECTED_ARGS ] ; then
     usage
-else
-    printf $(gcc -E $1 | grep "opts_insn" | \
-		 awk -F"=" '{print $2}' | sed 's/[[:space:];]*$//' | sed 's/\"//g')
 fi
+
+HEADER="$1"
+STR=$(gcc -E "$HEADER" | \
+      sed -n 's/.*char opts_insn[[:space:]]*\[\][^=]*=[[:space:]]*"\(.*\)"[[:space:]]*;.*/\1/p')
+
+if [ -z "$STR" ]; then
+    echo "$(basename "$0"): no opts_insn[] declaration found in $HEADER" >&2
+    exit 1
+fi
+
+printf '%b' "$STR"
diff --git a/scripts/hornet/extract-map.sh b/scripts/hornet/extract-map.sh
index 1d92ebe1a04b5..2d68bb473d889 100755
--- a/scripts/hornet/extract-map.sh
+++ b/scripts/hornet/extract-map.sh
@@ -21,7 +21,16 @@ EXPECTED_ARGS=1
 
 if [ $ARGC -ne $EXPECTED_ARGS ] ; then
     usage
-else
-    printf $(gcc -E $1 | grep "opts_data" | \
-		 awk -F"=" '{print $2}' | sed 's/[[:space:];]*$//' | sed 's/\"//g')
 fi
+
+# See extract-insn.sh for the rationale behind the sed/printf '%b' shape.
+HEADER="$1"
+STR=$(gcc -E "$HEADER" | \
+      sed -n 's/.*char opts_data[[:space:]]*\[\][^=]*=[[:space:]]*"\(.*\)"[[:space:]]*;.*/\1/p')
+
+if [ -z "$STR" ]; then
+    echo "$(basename "$0"): no opts_data[] declaration found in $HEADER" >&2
+    exit 1
+fi
+
+printf '%b' "$STR"
diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
index e115f4b7fdf74..c980f245f4a39 100755
--- a/scripts/hornet/extract-skel.sh
+++ b/scripts/hornet/extract-skel.sh
@@ -21,7 +21,26 @@ EXPECTED_ARGS=2
 
 if [ $ARGC -ne $EXPECTED_ARGS ] ; then
     usage
-else
-    printf $(gcc -E $1 | grep "static const char opts_$2" | \
-		 awk -F"=" '{print $2}' | sed 's/[[:space:];]*$//' | sed 's/\"//g')
 fi
+
+# See extract-insn.sh for the rationale behind the sed/printf '%b' shape.
+HEADER="$1"
+FIELD="$2"
+
+# Reject anything that could escape into the sed pattern below.
+case "$FIELD" in
+    *[!A-Za-z0-9_]*|"")
+        echo "$(basename "$0"): invalid field name '$FIELD'" >&2
+        exit 1
+        ;;
+esac
+
+STR=$(gcc -E "$HEADER" | \
+      sed -n "s/.*char opts_${FIELD}[[:space:]]*\[\][^=]*=[[:space:]]*\"\(.*\)\"[[:space:]]*;.*/\1/p")
+
+if [ -z "$STR" ]; then
+    echo "$(basename "$0"): no opts_${FIELD}[] declaration found in $HEADER" >&2
+    exit 1
+fi
+
+printf '%b' "$STR"
-- 
2.53.0

