Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B035959
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757376426; cv=none; b=Bc00lmYXe/2FQpF85MkPh5T3lFzKVsTHs1yM8MzHdQf+BHr0rlC6BLX9E9doUz0X+UVAvsUucNiHHWzCw93uNLuL4zbPyRqb6RzrBo+0euhkuk0OD5jDmpJT7hQNEqqwU1b2kaJBq2OJ3aDLA9hF7fu5SzcvEfo0eN3pslSWfr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757376426; c=relaxed/simple;
	bh=LAPOTmLxiYHsNFiHshRnt9fEDv79LnfjHgBJdE0Bu6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzfDZGWMZGKRygWQnkp5P01Ee4FIUSsaALvyHpxlSbBewbF7DNzJDEKct1GNbDbo67R61YX0uNh3ADYgVJdXMQgoKg1MJS6ed5d/q33eQw+AXA74+7q8HhVegzKBhKIHIunOfxRjfW1sRlHhHGKNMUtOQ4+qaEROSM9YwxD5N+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=uTc5k6uk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lc0b+Cvm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="uTc5k6uk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lc0b+Cvm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B9161D0018D;
	Mon,  8 Sep 2025 20:07:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 20:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757376423; x=
	1757462823; bh=q/ApXgYmYb44qmVuN0hBrt5s+4Kk8NcgNnk9+PPk3/Q=; b=u
	Tc5k6ukqEFXpKoIP21OkDoztofON3aECoG0ckIu/L8ZFqMdUMxzPMvLFgatDWvVJ
	NvnWPUR0QP32g2MxbK8Qe1RYM2zTa8RaLxnli6moiUn5mc/KFuTfq5T5gnkPEaMH
	i5Xy+n3NnUEwVBUL/i9XsbNIFt111XeKYNdn4y77E9a2tvTT49yX5PJyWgOFRuWD
	ZLEAHHKyMVWrGRkzQdbsXRF6at+ybpBL9837bwgEE76WOzJk79csyPcXZpgNPgbG
	yQurJdQZoD3lE66qnAyQvrgoTiqCN7dWrLwwkzifQjvtHaXc+/J/GXj68t1HFAoF
	s4ZcS2JYdM8nYrOQYoF/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757376423; x=1757462823; bh=q
	/ApXgYmYb44qmVuN0hBrt5s+4Kk8NcgNnk9+PPk3/Q=; b=Lc0b+CvmEU/8SviHj
	aNdzyOToqgiBA8bKlXgUkss3tUVokVMSD4GCFaM8jgWJ7uEQHZVyDUEkn7WD/HVT
	je45caDjRyaEWagQqm2QKC8dSWx7K+Tq325GzwHVbpl3z42txHkw/fyDfrj9wMQK
	GjrKS489QSOTiHfem3tJibGzlPO3Wu70NHA8VM8t0hPAWy+XplVOuTtIHqEp2An4
	8lfEPEiTApBWzUSjQCZX77BlaAAfWyCACthz7sx+4+CWTY/v8fIhXZxRf0vodZIa
	GFwueAJgRfX887ec68TXlOGPtQJTJXngVn2b1pEV51EGCNN8VCTUmTYPSH0/wJiA
	Z75lg==
X-ME-Sender: <xms:p2-_aFkbfYPGuKHO-dJn6N7jgai7LP3bz4I7zdjWfbSHXMVPa7uFQA>
    <xme:p2-_aMUt9WnjeDNUR0scoLYQ55Fx-UbFATePBY8lzaCPMhVc6AmUSnK_w1du4FIta
    Do9zii1DVywTdTdMPk>
X-ME-Received: <xmr:p2-_aCGlwPGoaguT-Bdj8APq22g3Q7u0AiAeZdjvJysGpxbURsJLsy1D4D7Gi62wkNvlhgi2fwqHKT0IdzIcUUj21BSJNgzpfH9mnU-3bOjfITLqIqhDspluhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhnghhmrgho
    ucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepuedutd
    ehhfehhfdvjeetvedvvdetfeffgeetteeugeeuleejfeeukeejteeiueelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrd
    horhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepmhesmhgrohifthhmrdhorh
    hgpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmh
    houghulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p2-_aAey4xCaE1qunisFH2849US_L4f2pL6Fnc7ivogzM3Nnp0wk2A>
    <xmx:p2-_aLJwVfc_Z-W61ZXMqlY3IQQ6W8zaZO2XTjdssCamMCttsvBe2g>
    <xmx:p2-_aNEv8qjnxG7UgiFRMjH1YzQfCzVktxPTV6sRe01JqHVCDokL2A>
    <xmx:p2-_aGBjMdBl2nM3pTqIAzDYKS6d2RSufsYtyNZo_0GPYazOMb8dTA>
    <xmx:p2-_aHj1fTCPWE7ubNHn4mZae8aYb_bwvQLJ3AsYCUa5C1t0jhtVSxXN>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 20:07:02 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 6/6] samples/landlock: Add FS quiet flag support to sandboxer
Date: Tue,  9 Sep 2025 01:06:40 +0100
Message-ID: <434a24b1ed42558788a6d585ea77294f3ac8cfb1.1757376311.git.m@maowtm.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757376311.git.m@maowtm.org>
References: <cover.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net rule support is TODO

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 samples/landlock/sandboxer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e7af02f98208..77c99329b3ba 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,6 +58,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 
 #define ENV_FS_RO_NAME "LL_FS_RO"
 #define ENV_FS_RW_NAME "LL_FS_RW"
+#define ENV_FS_QUIET_NAME "LL_FS_QUIET"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
@@ -116,7 +117,7 @@ static int parse_path(char *env_path, const char ***const path_list)
 /* clang-format on */
 
 static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
-			       const __u64 allowed_access)
+			       const __u64 allowed_access, bool quiet)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -166,7 +167,8 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-				      &path_beneath, 0)) {
+				      &path_beneath,
+				      quiet ? LANDLOCK_ADD_RULE_QUIET : 0)) {
 			fprintf(stderr,
 				"Failed to update the ruleset with \"%s\": %s\n",
 				path_list[i], strerror(errno));
@@ -328,6 +330,7 @@ static const char help[] =
 	"\n"
 	"A sandboxer should not log denied access requests to avoid spamming logs, "
 	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
+	ENV_FS_QUIET_NAME " can then be used to make access to some denied paths not trigger audit logging.\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -497,12 +500,21 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
-	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
+	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro,
+				false)) {
 		goto err_close_ruleset;
 	}
-	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
+	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw,
+				false)) {
 		goto err_close_ruleset;
 	}
+	/* Don't require this env to be present */
+	if (getenv(ENV_FS_QUIET_NAME)) {
+		if (populate_ruleset_fs(ENV_FS_QUIET_NAME, ruleset_fd, 0,
+					true)) {
+			goto err_close_ruleset;
+		}
+	}
 
 	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
 				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
-- 
2.51.0

