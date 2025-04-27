Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BD1DE2C9;
	Sun, 27 Apr 2025 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745717919; cv=none; b=HR3qKJTZgSu7S8aRM2PgwFVtRCldlIkauHhUBGnf0OLb4CQk2VCiAysPOfS7JMCzTr0cs5JBUBkOARQbnwnLcVLPIQlTketurIw65d9XrlPslwKVs3S8eB8B34OuTF8bNT9kQjE7DXnJbHEOfVzao6R/Fe1guqhpeB6jUReTalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745717919; c=relaxed/simple;
	bh=ZgdoQkssZwtgKxsSyH83cNs9nHOLWMIdu0B1U5RulHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOhKqm/piRZaekPoSSBz348oJ+V+RSr2csDcU5q7lXVXy33WPueF2gqXLSzj/KvGIb0s3x07cnDgk+28twpXQHWwYd0pDtO3EDCRbPdQP6RwKLnV9xOzHu/z0zp84WFOIJKilakESrTKwbjAj+I2V0w+fesw70MfYEH/aDQwgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKhpFlMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKhpFlMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DAC4CEEA;
	Sun, 27 Apr 2025 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745717918;
	bh=ZgdoQkssZwtgKxsSyH83cNs9nHOLWMIdu0B1U5RulHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKhpFlMw1vEPcyVhEh8gNMV2G7Ht8ORqhW2ugENa1pSqmfiFX/MJhdGrVRUsfeicl
	 a21Zyawsxo+eRlcT1EYu9IfgBsHEmQ/3oQwB9KWjp1/U5c7M0o0gN31cTY3sz9plc0
	 EYrG0GfTSMhdJn+l+rwJxDq2XeIFj4UGTEtEIBvNwVwcj/bI0i0lIEGm8Z77IfX0aR
	 vixC1Cyjzfd9IR6iacVmDJ1M1fRK5T6RWbv33rjewaf9sMEMV5+yBWUNW5yVanMlTD
	 8PifQKWeegD33ATnmY9behhd4djKFygzq/aGo/gEVQt/uVjoz5p2J2Z/Vf16KYHuK1
	 OJ+fXVn2Lubsw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Mark Brown <broonie@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Bill Wendling <morbo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Petr Mladek <pmladek@suse.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] randstruct: gcc-plugin: Remove bogus void member
Date: Sat, 26 Apr 2025 18:38:33 -0700
Message-Id: <20250427013836.877214-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427013604.work.926-kees@kernel.org>
References: <20250427013604.work.926-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4947; i=kees@kernel.org; h=from:subject; bh=ZgdoQkssZwtgKxsSyH83cNs9nHOLWMIdu0B1U5RulHc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBm8XbPcJ+o/eOrw2+939mwfK8E7a7SYHQ40mAsck58+T /N0LV9tRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQKuhkZFl1qWzaZOcW14+Hx NheftgNlJV7/0zIYje5EZdx54XGuhZHhQ0TxVTbBCYVPFi9fFPzh89OVjxK5PG20YtsmqhQkH57 GAgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When building the randomized replacement tree of struct members, the
randstruct GCC plugin would insert, as the first member, a 0-sized void
member. This appears as though it was done to catch non-designated
("unnamed") static initializers, which wouldn't be stable since they
depend on the original struct layout order.

This was accomplished by having the side-effect of the "void member"
tripping an assert in GCC internals (count_type_elements) if the member
list ever needed to be counted (e.g. for figuring out the order of members
during a non-designated initialization), which would catch impossible type
(void) in the struct:

security/landlock/fs.c: In function ‘hook_file_ioctl_common’:
security/landlock/fs.c:1745:61: internal compiler error: in count_type_elements, at expr.cc:7075
 1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
      |                                                             ^

static HOST_WIDE_INT
count_type_elements (const_tree type, bool for_ctor_p)
{
  switch (TREE_CODE (type))
...
    case VOID_TYPE:
    default:
      gcc_unreachable ();
    }
}

However this is a redundant safety measure since randstruct uses the
__designated_initializer attribute both internally and within the
__randomized_layout attribute macro so that this would be enforced
by the compiler directly even when randstruct was not enabled (via
-Wdesignated-init).

A recent change in Landlock ended up tripping the same member counting
routine when using a full-struct copy initializer as part of an anonymous
initializer. This, however, is a false positive as the initializer is
copying between identical structs (and hence identical layouts). The
"path" member is "struct path", a randomized struct, and is being copied
to from another "struct path", the "f_path" member:

        landlock_log_denial(landlock_cred(file->f_cred), &(struct landlock_request) {
                .type = LANDLOCK_REQUEST_FS_ACCESS,
                .audit = {
                        .type = LSM_AUDIT_DATA_IOCTL_OP,
                        .u.op = &(struct lsm_ioctlop_audit) {
                                .path = file->f_path,
                                .cmd = cmd,
                        },
                },
	...

As can be seen with the coming randstruct KUnit test, there appears to
be no behavioral problems with this kind of initialization when the void
member is removed from the randstruct GCC plugin, so remove it.

Reported-by: "Dr. David Alan Gilbert" <linux@treblig.org>
Closes: https://lore.kernel.org/lkml/Z_PRaKx7q70MKgCA@gallifrey/
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/lkml/20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org/
Reported-by: WangYuli <wangyuli@uniontech.com>
Closes: https://lore.kernel.org/lkml/337D5D4887277B27+3c677db3-a8b9-47f0-93a4-7809355f1381@uniontech.com/
Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: Mark Brown <broonie@kernel.org>
Cc: "Günther Noack" <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 5694df3da2e9..971a1908a8cc 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -344,29 +344,13 @@ static int relayout_struct(tree type)
 
 	shuffle(type, (tree *)newtree, shuffle_length);
 
-	/*
-	 * set up a bogus anonymous struct field designed to error out on unnamed struct initializers
-	 * as gcc provides no other way to detect such code
-	 */
-	list = make_node(FIELD_DECL);
-	TREE_CHAIN(list) = newtree[0];
-	TREE_TYPE(list) = void_type_node;
-	DECL_SIZE(list) = bitsize_zero_node;
-	DECL_NONADDRESSABLE_P(list) = 1;
-	DECL_FIELD_BIT_OFFSET(list) = bitsize_zero_node;
-	DECL_SIZE_UNIT(list) = size_zero_node;
-	DECL_FIELD_OFFSET(list) = size_zero_node;
-	DECL_CONTEXT(list) = type;
-	// to satisfy the constify plugin
-	TREE_READONLY(list) = 1;
-
 	for (i = 0; i < num_fields - 1; i++)
 		TREE_CHAIN(newtree[i]) = newtree[i+1];
 	TREE_CHAIN(newtree[num_fields - 1]) = NULL_TREE;
 
 	main_variant = TYPE_MAIN_VARIANT(type);
 	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_FIELDS(variant) = list;
+		TYPE_FIELDS(variant) = newtree[0];
 		TYPE_ATTRIBUTES(variant) = copy_list(TYPE_ATTRIBUTES(variant));
 		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("randomize_performed"), NULL_TREE, TYPE_ATTRIBUTES(variant));
 		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("designated_init"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-- 
2.34.1

