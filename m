Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/+Mpyoi"
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071201988
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:35 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-53fa5cd4480so1272524a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847033; x=1701451833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htkkmhnB8YP/fghitgYQJQw3N64RwGKcz1JP0qCYN4U=;
        b=2/+Mpyoit2qSHZo6oBCbRq6QW+JXUf7jc8mYg/VLd7KBtux80P8vzBXtEte1wBaqQm
         qSLpHnCnkZ4bzS1BVPHIpxTMCnK/1X0g0FT8HIXPuvEObeweAVFG+d3uk/Xb/Qu5zVAM
         OdBovc/xkbjJwM8Wmlp01+Cm9ph4MACJmTDSpO0LxkSfX86l3XR0OyJtkQ7fe6aFO4gF
         fBLyesp6V0HlU32mCmZxVquxQwM2Q+TOfU2JtFhfcpHVgJXre+5EbVTuQQUNI3I1xOVL
         5xSrsxNyG8eRt+ok+/MrRFfuGpITfnH0v4+Ln+lilaojySIza2drD+JSutwdnDBOEQsT
         m1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847033; x=1701451833;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htkkmhnB8YP/fghitgYQJQw3N64RwGKcz1JP0qCYN4U=;
        b=erMYA0x7NhmVOoNxPOnSbYVGbU5JDuUxrKJKJ7+WzfChjdRnAAB3xeQ57yVqqOQfZ/
         onOPGBWK2CxF3mRUf79NhaPXKL4oqPuVeV9GG+NRRITyOkqNlrDINucpXcxQWRU6YqPb
         Kfch6RCmQxsDmP0yEflLMwbFc3vSlzqA0UjcGcByK4HKqo+ClbWXpflFcFP7AzNwFrYr
         zoGCorigwG5hj47QGLgElZ5o9TsomT0bUpWxxp5LLMtxVb888omrN4UENZ4nU//XbXNv
         Uwarm2eZfm5f2xi7pXCasZavZZYEQ/aw/a3EeWlUR6qgKHbNDh5GccCMwFYkvOWneESC
         yZfw==
X-Gm-Message-State: AOJu0YyagHDa6x7In7sjpWlhgnKcZGZhcH3ufXHL+gH3dOyUr8srPCdn
	o26V040SE8qbbOz9V7zEn5/KBBimjOR0HBviOwqjXhuZP9478rIfn+a/PP3C14S489KDd9cEknK
	REG09SghDqk/yVkSVO2SUCj4DcHG1QEGs4Dup7GCGUtbBWFQsKZUxHYAvhMLnk+4bG8+Ph9VjGn
	eUByzXxw==
X-Google-Smtp-Source: AGHT+IFD6pvC2bIUmE05s8isjudW7s380IZ2nghEWms8TE3dGKr6bxAr2LNOyFhXZRuM37n/OaQafaXZkVk=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a05:6402:254d:b0:542:d5b2:a6c9 with SMTP id
 l13-20020a056402254d00b00542d5b2a6c9mr52257edb.0.1700847033541; Fri, 24 Nov
 2023 09:30:33 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:18 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 1/9] landlock: Remove remaining "inline" modifiers in .c files
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 security/landlock/fs.c      | 26 +++++++++++++-------------
 security/landlock/ruleset.c |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bc7c126deea2..9ba989ef46a5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -193,7 +193,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *co=
nst ruleset,
  *
  * Returns NULL if no rule is found or if @dentry is negative.
  */
-static inline const struct landlock_rule *
+static const struct landlock_rule *
 find_rule(const struct landlock_ruleset *const domain,
 	  const struct dentry *const dentry)
 {
@@ -220,7 +220,7 @@ find_rule(const struct landlock_ruleset *const domain,
  * sockfs, pipefs), but can still be reachable through
  * /proc/<pid>/fd/<file-descriptor>
  */
-static inline bool is_nouser_or_private(const struct dentry *dentry)
+static bool is_nouser_or_private(const struct dentry *dentry)
 {
 	return (dentry->d_sb->s_flags & SB_NOUSER) ||
 	       (d_is_positive(dentry) &&
@@ -264,7 +264,7 @@ static const struct landlock_ruleset *get_current_fs_do=
main(void)
  *
  * @layer_masks_child2: Optional child masks.
  */
-static inline bool no_more_access(
+static bool no_more_access(
 	const layer_mask_t (*const layer_masks_parent1)[LANDLOCK_NUM_ACCESS_FS],
 	const layer_mask_t (*const layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS],
 	const bool child1_is_directory,
@@ -316,7 +316,7 @@ static inline bool no_more_access(
  *
  * Returns true if the request is allowed, false otherwise.
  */
-static inline bool
+static bool
 scope_to_request(const access_mask_t access_request,
 		 layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS])
 {
@@ -335,7 +335,7 @@ scope_to_request(const access_mask_t access_request,
  * Returns true if there is at least one access right different than
  * LANDLOCK_ACCESS_FS_REFER.
  */
-static inline bool
+static bool
 is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 	  const access_mask_t access_request)
 {
@@ -551,9 +551,9 @@ static bool is_access_to_paths_allowed(
 	return allowed_parent1 && allowed_parent2;
 }
=20
-static inline int check_access_path(const struct landlock_ruleset *const d=
omain,
-				    const struct path *const path,
-				    access_mask_t access_request)
+static int check_access_path(const struct landlock_ruleset *const domain,
+			     const struct path *const path,
+			     access_mask_t access_request)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
=20
@@ -565,8 +565,8 @@ static inline int check_access_path(const struct landlo=
ck_ruleset *const domain,
 	return -EACCES;
 }
=20
-static inline int current_check_access_path(const struct path *const path,
-					    const access_mask_t access_request)
+static int current_check_access_path(const struct path *const path,
+				     const access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom =3D get_current_fs_domain();
=20
@@ -575,7 +575,7 @@ static inline int current_check_access_path(const struc=
t path *const path,
 	return check_access_path(dom, path, access_request);
 }
=20
-static inline access_mask_t get_mode_access(const umode_t mode)
+static access_mask_t get_mode_access(const umode_t mode)
 {
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
@@ -600,7 +600,7 @@ static inline access_mask_t get_mode_access(const umode=
_t mode)
 	}
 }
=20
-static inline access_mask_t maybe_remove(const struct dentry *const dentry=
)
+static access_mask_t maybe_remove(const struct dentry *const dentry)
 {
 	if (d_is_negative(dentry))
 		return 0;
@@ -1086,7 +1086,7 @@ static int hook_path_truncate(const struct path *cons=
t path)
  * Returns the access rights that are required for opening the given file,
  * depending on the file type and open mode.
  */
-static inline access_mask_t
+static access_mask_t
 get_required_file_open_access(const struct file *const file)
 {
 	access_mask_t access =3D 0;
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index ffedc99f2b68..789c81b26a50 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -305,7 +305,7 @@ int landlock_insert_rule(struct landlock_ruleset *const=
 ruleset,
 	return insert_rule(ruleset, id, &layers, ARRAY_SIZE(layers));
 }
=20
-static inline void get_hierarchy(struct landlock_hierarchy *const hierarch=
y)
+static void get_hierarchy(struct landlock_hierarchy *const hierarchy)
 {
 	if (hierarchy)
 		refcount_inc(&hierarchy->usage);
--=20
2.43.0.rc1.413.gea7ed67945-goog

