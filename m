Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4FA279DCC
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937799; cv=none; b=i0jsc7iMdGyCLLRWSEDUfHTfTIB7DQOAcp8f4BLk8Q3FKvhQ51628PfA+M0NWo10ZpedNl/q6SMXJZFT5E8Auc+CNE1pK9j5kMjmTo/mqPax5YGBp9k73IX1vbRisWbf48MHfbYeEwKGkzpI3nVe3GgocmMOMxguUbEjOb1MgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937799; c=relaxed/simple;
	bh=oyLAHKof3hQNq3WtGbHXF9CqeiS7sP5O3FJhUJv0Cfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhnEKOPvrdL8wb20uyE0C0OQPzseDDiO9EgVh5V8JgsTyOxQFz+3GN2X33iAcvkF+AuMBBub3SCIhe0KK2EnhoClyx2dgDB4j1S8Xsn+GGjtLYlXuYcDhKxv5JfrzZoFn4vXQSKRfc+xbZHs4VHHjaIf47JHA600ie1l3FF3BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SYCJyRs+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SYCJyRs+"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0094A20B7167;
	Wed, 27 May 2026 20:09:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0094A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937783;
	bh=ZwYC+qBl3xFXY/Wn+bhnP9euMCnV4Ivuo8C9GCo8lkI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SYCJyRs+pjhO5cbi8+9m5du5U4ewyEcmCCQYjzBBW2f/w9vM/yxXQvz9eBYpNd1cz
	 5x9drf8MXEkiHKQrhkJTMBwtVq1EUVWjI2AJfLFEVB3luxnK6cUnUHcUsuxUqFeuLB
	 jl8F0prj2fBbdcob7v6B/TwLD5dsRAXnq/vx1nN0=
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
Subject: [PATCH 10/11] hornet: scripts: harden scripts to handle trailing whitespace
Date: Wed, 27 May 2026 20:08:19 -0700
Message-ID: <20260528030915.2654994-11-bboscaccy@linux.microsoft.com>
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

Trailing whitespace after the semicolon in the header files may have
caused the binary extracted payload to be corrupted due to a missing
anchor.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/extract-insn.sh | 2 +-
 scripts/hornet/extract-map.sh  | 2 +-
 scripts/hornet/extract-skel.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/hornet/extract-insn.sh b/scripts/hornet/extract-insn.sh
index e136932275aa5..3e7bed049acb6 100755
--- a/scripts/hornet/extract-insn.sh
+++ b/scripts/hornet/extract-insn.sh
@@ -23,5 +23,5 @@ if [ $ARGC -ne $EXPECTED_ARGS ] ; then
     usage
 else
     printf $(gcc -E $1 | grep "opts_insn" | \
-		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+		 awk -F"=" '{print $2}' | sed 's/[[:space:];]*$//' | sed 's/\"//g')
 fi
diff --git a/scripts/hornet/extract-map.sh b/scripts/hornet/extract-map.sh
index 058ac1b32d743..1d92ebe1a04b5 100755
--- a/scripts/hornet/extract-map.sh
+++ b/scripts/hornet/extract-map.sh
@@ -23,5 +23,5 @@ if [ $ARGC -ne $EXPECTED_ARGS ] ; then
     usage
 else
     printf $(gcc -E $1 | grep "opts_data" | \
-		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+		 awk -F"=" '{print $2}' | sed 's/[[:space:];]*$//' | sed 's/\"//g')
 fi
diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
index abc435e2bcd4e..e115f4b7fdf74 100755
--- a/scripts/hornet/extract-skel.sh
+++ b/scripts/hornet/extract-skel.sh
@@ -23,5 +23,5 @@ if [ $ARGC -ne $EXPECTED_ARGS ] ; then
     usage
 else
     printf $(gcc -E $1 | grep "static const char opts_$2" | \
-		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+		 awk -F"=" '{print $2}' | sed 's/[[:space:];]*$//' | sed 's/\"//g')
 fi
-- 
2.53.0

