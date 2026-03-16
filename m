Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4E86347;
	Mon, 16 Mar 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669620; cv=none; b=H1WPBCAmA6Y34H8iuee1tcU2jxwqpKSp4XLU7C4Vw0WjU5/sy3oUV7gVIrd7+KhYjiwWM4jhhXoPDJTEYgR1GU6p6LArWCClbaXDqPpMssZxObxippNTKayzDSBFFaigdEqbQZUA1YH9JsJOTb8u+X1tYF/GsE1vSu9bK19iZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669620; c=relaxed/simple;
	bh=ZXniKfwqTuyKAhrEeLyabGQ++dWZYhueNjMLZfQd1c0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=liUjBXb5LxDNMI0aJpBYYbeCrJgDeceNPRJPYD/sIXOKTru6K7mCsRiyepaILjiBtoFU6Ugt/S9CdVMK9wjPjmj0g9Pe5XredxCeAFHbDAmJvYr9WEaSNR2M0XUS5zDJCmffoRSmLJ2T4luo1+klJO4kgZRtbmoJI3RGjQjFmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOSY8sWE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOSY8sWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DA3C19421;
	Mon, 16 Mar 2026 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773669620;
	bh=ZXniKfwqTuyKAhrEeLyabGQ++dWZYhueNjMLZfQd1c0=;
	h=From:To:Cc:Subject:Date:From;
	b=IOSY8sWEbWN6DC1HmsO30r374zHzdHKF9dTcoaj8q/KiO0UHKS6bw8MrTgsDy0SXB
	 J6YUvMj/sWHADhS57aBvnECm3dBuBOL1lKYGReRgWMY1RL6DMK2M7MZ/fHl8tKUnyT
	 HN8vuw8Xy1vmQSvmZ1Ucyp1BE2XoMYCy6ZAuiuUaTTQ6bXaYqtkPnB3OK+cqJfzsbH
	 p3HQYqa9JDIP1jVLItdYI9ZgxDLe4jWOsNnwOnqmfLtzrVwArnIWrFYUJV9UTlU6H5
	 EpDjK4Kd5J9MLS1M5tz0evPnekSGADRTS3F9ySD2CENXOx/3zlklNUlVlECOtaotU1
	 eGofhNap7ILFw==
From: Arnd Bergmann <arnd@kernel.org>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: hide unused get_loaddata_common_ref() function
Date: Mon, 16 Mar 2026 14:59:31 +0100
Message-Id: <20260316135935.3321551-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced function is only used in an #ifdef block,
which causes a harmless warning:

security/apparmor/apparmorfs.c:177:28: error: 'get_loaddata_common_ref' defined but not used [-Werror=unused-function]
  177 | static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)

Move the definition next to the user to avoid the warning.

Fixes: 8e135b8aee5a ("apparmor: fix race between freeing data and fs accessing it")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Alternatively, the #ifdef checks could be replaced with an
'if(IS_ENABLED(CONFIG_SECURITY_APPARMOR_EXPORT_BINARY) return;'
check in __aa_fs_create_rawdata(), relying on the compiler's
dead code elimination.
---
 security/apparmor/apparmorfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index ededaf46f3ca..f762b101d682 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -174,14 +174,6 @@ static struct aa_proxy *get_proxy_common_ref(struct aa_common_ref *ref)
 	return NULL;
 }
 
-static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
-{
-	if (ref)
-		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
-						      count));
-	return NULL;
-}
-
 static void aa_put_common_ref(struct aa_common_ref *ref)
 {
 	if (!ref)
@@ -1318,6 +1310,14 @@ static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
 	.release	= seq_rawdata_release,				      \
 }									      \
 
+static struct aa_loaddata *get_loaddata_common_ref(struct aa_common_ref *ref)
+{
+	if (ref)
+		return aa_get_i_loaddata(container_of(ref, struct aa_loaddata,
+						      count));
+	return NULL;
+}
+
 static int seq_rawdata_open(struct inode *inode, struct file *file,
 			    int (*show)(struct seq_file *, void *))
 {
-- 
2.39.5

