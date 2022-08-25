Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3419EECAAA2
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiHYWQI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiHYWQH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 18:16:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1E6D574
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 15:16:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so50990edc.1
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=ceakZOZIoNjhoaYAMLrGbAR5qna5Vu/JN7HofwEp6t4=;
        b=bFwh1NO24md9NBw0CI+bB2szwhb5DAN7RSnV+8CxfPOlSDOFSFrz61X/y98plQ75lL
         M4dKqw1x3XHhLVra7SqG2JiVzIffaGc/ghi7U3xyVYyDGiZo64jjSNhaXDn3GHxo6tuo
         8ccUj1ROibe/j5qIxTKyhPFPDGEulTb/f2MjoutNd//emNXDWP4xK3d8/d82jDvmIebL
         R4vZ15xOFgptPqSfpxXFC9+EYu/p8XiU+Jjz4PVzcE0xb7IaK8819Cci3swI7vDqFC9A
         ZWg+dPY21+fIERzyjPNl1nr6qHkkqZqOehXbNUL8cY/ugLIWET13jV8ax3+D/55Tckvr
         DwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=ceakZOZIoNjhoaYAMLrGbAR5qna5Vu/JN7HofwEp6t4=;
        b=79qU4JV8ZsBC7VS3eBTxALe0oxOMHzcfMj6zkoOnAMmqhZ6YKeEvs9UQsb5ujFXGPA
         T8RRafhWIyaMKR5As0hafVADAI6a1nlYueiwg5rjRYBIAsf2ifKnovfBI9g1+AlX/aSD
         Qd3vBbmQJ71hdntKmAAQKsqTLJref0Wb27qBrAwMJZP6VlT0sOYdqYP4d9/y12W0Zhj4
         FuQsQrorFOE6XXsx8V4PzyV3+UR9mOdQ1BQt90ZQD8uwHlmvfjvtZ4sPxzt7Ckgc8ILU
         CsssBb5H07Pd86J+dtffsggifyEXAbJBIpxyxKCT2799Svfwd0ddMwrOubOa1k/1lKFo
         xuWg==
X-Gm-Message-State: ACgBeo2X+bSuMxM/5YIQ6nb6prNW6xOZYlydZBzSLBXzDym4HJV98rmZ
        mRxLW5tj+O0H3+N8PXiOy8RL6fVYlFs=
X-Google-Smtp-Source: AA6agR47DJed3Nsd0B0UZcQg4T4K3A20nTOtz9ohKyEWlXuOTydOEM2U5ywIwPlneXZ6NdTN8FM5HA==
X-Received: by 2002:a50:d597:0:b0:447:96e8:9f25 with SMTP id v23-20020a50d597000000b0044796e89f25mr4720304edi.208.1661465764327;
        Thu, 25 Aug 2022 15:16:04 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b00730f0c19108sm145611ejg.86.2022.08.25.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:16:03 -0700 (PDT)
Date:   Fri, 26 Aug 2022 00:16:02 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <Ywf0okWNl4gRXTYL@nuc>
References: <20220823144123.633721-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823144123.633721-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 23, 2022 at 04:41:23PM +0200, Mickaël Salaün wrote:
> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
> globally denied-by-default access right.  Indeed, this lifted an initial
> Landlock limitation to rename and link files, which was initially always
> denied when the source or the destination were different directories.
>
> This led to an inconsistent backward compatibility behavior which was
> only taken into account if no domain layer were using the new
> LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers are
> using the first and the second Landlock ABI (i.e.
> LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if all
> domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
> implicitely allowing such right.  Indeed, the not-handled access rights
> were allowed, which should not be the case for LANDLOCK_ACCESS_FS_REFER.
> It should be noted that this bug only allowed safe renames or links, but
> no privilege escalation because the LANDLOCK_ACCESS_FS_REFER properties
> were still enforced (e.g. only allowed to move a file according to all
> other access rights, and if it doesn't give more Landlock accesses).
>
> This change adds an ACCESS_INITIALLY_DENIED list of denied-by-default
> rights, which (only) contains LANDLOCK_ACCESS_FS_REFER.  All domains are
> treated as if they are also handling this list, but without modifying
> their fs_access_masks field, which enables correct domain audit.
>
> A side effect is that the errno code returned by rename(2) or link(2)
> *may* be changed from EXDEV to EACCES according to the enforced
> restrictions.  Indeed, we now have the mechanic to identify if an access
> is denied because of a required right (e.g. LANDLOCK_ACCESS_FS_MAKE_REG,
> LANDLOCK_ACCESS_FS_REMOVE_FILE) or if it is denied because of missing
> LANDLOCK_ACCESS_FS_REFER rights.  This may result in different errno
> codes than for the initial Landlock version, but this approach is better
> for rename/link compatibility reasons, and it wasn't possible before
> (hence no backport to ABI v1).  The layout1.rename_file test reflects
> this change.
>
> Add the layout1.refer_denied_by_default* tests to check that the
> behavior of a ruleset not handling LANDLOCK_ACCESS_FS_REFER (ABI v1) is
> unchanged even if another layer handles LANDLOCK_ACCESS_FS_REFER (i.e.
> ABI v1 precedence).  Make sure rule's absolute access rights are correct
> by testing with and without a matching path.
>
> Extend layout1.inval tests to check that a denied-by-default access
> right is not necessarily part of a domain's handled access rights.
>
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220823144123.633721-1-mic@digikod.net
> ---
>  security/landlock/fs.c                     |  28 +++--
>  tools/testing/selftests/landlock/fs_test.c | 133 +++++++++++++++++++--
>  2 files changed, 143 insertions(+), 18 deletions(-)
>
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index ec5a6247cd3e..0cf484e89f68 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -149,6 +149,15 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_READ_FILE)
>  /* clang-format on */
>
> +/*
> + * All access rights that are denied by default whether they are handled or not
> + * by a ruleset/layer.
> + */
> +/* clang-format off */
> +#define ACCESS_INITIALLY_DENIED ( \
> +	LANDLOCK_ACCESS_FS_REFER)
> +/* clang-format on */
> +
>  /*
>   * @path: Should have been checked by get_path_from_fd().
>   */
> @@ -167,7 +176,9 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  		return -EINVAL;
>
>  	/* Transforms relative access rights to absolute ones. */
> -	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~ruleset->fs_access_masks[0];
> +	access_rights |=
> +		LANDLOCK_MASK_ACCESS_FS &
> +		~(ruleset->fs_access_masks[0] | ACCESS_INITIALLY_DENIED);
>
>  	object = get_inode_object(d_backing_inode(path->dentry));
>  	if (IS_ERR(object))
>  		return PTR_ERR(object);
> @@ -277,7 +288,7 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
>  static inline access_mask_t
>  get_handled_accesses(const struct landlock_ruleset *const domain)
>  {
> -	access_mask_t access_dom = 0;
> +	access_mask_t access_dom = ACCESS_INITIALLY_DENIED;
>  	unsigned long access_bit;
>
>  	for (access_bit = 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
> @@ -316,8 +327,13 @@ init_layer_masks(const struct landlock_ruleset *const domain,
>
>  		for_each_set_bit(access_bit, &access_req,
>  				 ARRAY_SIZE(*layer_masks)) {
> -			if (domain->fs_access_masks[layer_level] &
> -			    BIT_ULL(access_bit)) {
> +			/*
> +			 * Artificially handles all initially denied by default
> +			 * access rights.
> +			 */
> +			if (BIT_ULL(access_bit) &
> +			    (domain->fs_access_masks[layer_level] |
> +			     ACCESS_INITIALLY_DENIED)) {
>  				(*layer_masks)[access_bit] |=
>  					BIT_ULL(layer_level);
>  				handled_accesses |= BIT_ULL(access_bit);
> @@ -857,10 +873,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  					      NULL, NULL);
>  	}
>
> -	/* Backward compatibility: no reparenting support. */
> -	if (!(get_handled_accesses(dom) & LANDLOCK_ACCESS_FS_REFER))
> -		return -EXDEV;
> -
>  	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
>  	access_request_parent2 |= LANDLOCK_ACCESS_FS_REFER;
>

In this change, you are adding "| ACCESS_INITIALLY_DENIED" to a bunch
of places in fs.c where a domain->fs_access_masks[...] is read.

In the documentation for the refer right, it is described with:

  This is also the only access right which is always considered
  handled by any ruleset in such a way that reparenting a file
  hierarchy is always denied by default.

Naive question: Is anything keeping us from also implementing it in
that way? We could pretend early during ruleset creation that the
caller had asked to also handle the "refer" right. Then we would just
have the "refer" bit set on every domain->fs_access_masks[...] entry.

Wouldn't that do the same, without further complicating the access
check logic in fs.c?

FWIW, one thing that would happen in this approach would be that users
could add rules asking to grant the "refer" right on files, on
rulesets where they have not previously declared it as a "handled"
right. It's debatable whether that is good API design, but it would
not do much damage either, and could also be fixed by keeping a copy
of the originally requested handled_access_fs.

—Günther

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21a2ce8fa739..2c134a9202a1 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
>   * Copyright © 2020 ANSSI
> - * Copyright © 2020-2021 Microsoft Corporation
> + * Copyright © 2020-2022 Microsoft Corporation
>   */
>
>  #define _GNU_SOURCE
> @@ -371,6 +371,13 @@ TEST_F_FORK(layout1, inval)
>  	ASSERT_EQ(EINVAL, errno);
>  	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
>
> +	/* Tests with denied-by-default access right. */
> +	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_REFER;
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_REFER;
> +
>  	/* Test with unknown (64-bits) value. */
>  	path_beneath.allowed_access |= (1ULL << 60);
>  	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> @@ -1867,10 +1874,10 @@ TEST_F_FORK(layout1, rename_file)
>  	 * to a different directory (which allows file removal).
>  	 */
>  	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
> -	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(EACCES, errno);
>  	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file1_s1d3,
>  				RENAME_EXCHANGE));
> -	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(EACCES, errno);
>  	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s1d3,
>  				RENAME_EXCHANGE));
>  	ASSERT_EQ(EXDEV, errno);
> @@ -1894,7 +1901,7 @@ TEST_F_FORK(layout1, rename_file)
>  	ASSERT_EQ(EXDEV, errno);
>  	ASSERT_EQ(0, unlink(file1_s1d3));
>  	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
> -	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(EACCES, errno);
>
>  	/* Exchanges and renames files with same parent. */
>  	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
> @@ -2014,6 +2021,107 @@ TEST_F_FORK(layout1, reparent_refer)
>  	ASSERT_EQ(0, rename(dir_s1d3, dir_s2d3));
>  }
>
> +/* Checks renames beneath dir_s1d1. */
> +static void refer_denied_by_default(struct __test_metadata *const _metadata,
> +				    const struct rule layer1_abi_v2[],
> +				    const struct rule layer2_abi_v1[])
> +{
> +	int ruleset_fd;
> +
> +	ASSERT_EQ(0, unlink(file1_s1d2));
> +
> +	/*
> +	 * First layer, which handles LANDLOCK_ACCESS_FS_REFER, can allow some
> +	 * different-parent renames and links.
> +	 */
> +	ruleset_fd = create_ruleset(_metadata, layer1_abi_v2[0].access,
> +				    layer1_abi_v2);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks that legitimate renames are allowed. */
> +	ASSERT_EQ(0, rename(file1_s1d1, file1_s1d2));
> +	ASSERT_EQ(0, rename(file1_s1d2, file1_s1d1));
> +	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d2,
> +			       RENAME_EXCHANGE));
> +	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s1d2, AT_FDCWD, file2_s1d1,
> +			       RENAME_EXCHANGE));
> +
> +	/*
> +	 * Second layer, which does not handle LANDLOCK_ACCESS_FS_REFER, denies
> +	 * any different-parent renames and links, thus making the first layer
> +	 * null and void.
> +	 */
> +	ruleset_fd = create_ruleset(_metadata, layer2_abi_v1[0].access,
> +				    layer2_abi_v1);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks that all renames are now denied. */
> +	ASSERT_EQ(-1, rename(file1_s1d1, file1_s1d2));
> +	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d1, AT_FDCWD, file2_s1d2,
> +				RENAME_EXCHANGE));
> +	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(-1, renameat2(AT_FDCWD, file2_s1d2, AT_FDCWD, file2_s1d1,
> +				RENAME_EXCHANGE));
> +	ASSERT_EQ(EXDEV, errno);
> +}
> +
> +/*
> + * Tests precedence over renames: denied by default for different parent
> + * directories, *with* a rule matching a parent directory, but not directly
> + * denying access (with MAKE_REG nor REMOVE).
> + */
> +TEST_F_FORK(layout1, refer_denied_by_default1)
> +{
> +	const struct rule layer1_abi_v2[] = {
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_REFER,
> +		},
> +		{},
> +	};
> +	const struct rule layer2_abi_v1[] = {
> +		{
> +			/* Matches a parent directory. */
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		},
> +		{},
> +	};
> +
> +	refer_denied_by_default(_metadata, layer1_abi_v2, layer2_abi_v1);
> +}
> +
> +/*
> + * Tests precedence over renames: denied by default for different parent
> + * directories, *without* a rule matching a parent directory, but not directly
> + * denying access (with MAKE_REG nor REMOVE).
> + */
> +TEST_F_FORK(layout1, refer_denied_by_default2)
> +{
> +	const struct rule layer1_abi_v2[] = {
> +		{
> +			.path = dir_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_REFER,
> +		},
> +		{},
> +	};
> +	const struct rule layer2_abi_v1[] = {
> +		{
> +			/* Does not match a parent directory. */
> +			.path = dir_s2d1,
> +			.access = LANDLOCK_ACCESS_FS_EXECUTE,
> +		},
> +		{},
> +	};
> +
> +	refer_denied_by_default(_metadata, layer1_abi_v2, layer2_abi_v1);
> +}
> +
>  TEST_F_FORK(layout1, reparent_link)
>  {
>  	const struct rule layer1[] = {
> @@ -2336,11 +2444,12 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
>  	ASSERT_EQ(EXDEV, errno);
>
>  	/*
> -	 * However, moving the file2_s1d3 file below dir_s2d3 is allowed
> -	 * because it cannot inherit MAKE_REG nor MAKE_DIR rights (which are
> -	 * dedicated to directories).
> +	 * Moving the file2_s1d3 file below dir_s2d3 is denied because the
> +	 * second layer does not handle REFER, which is always denied by
> +	 * default.
>  	 */
> -	ASSERT_EQ(0, rename(file2_s1d3, file1_s2d3));
> +	ASSERT_EQ(-1, rename(file2_s1d3, file1_s2d3));
> +	ASSERT_EQ(EXDEV, errno);
>  }
>
>  TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
> @@ -2373,8 +2482,12 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
>  	ASSERT_EQ(EACCES, errno);
>  	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
>  	ASSERT_EQ(EXDEV, errno);
> -	/* Modify layout! */
> -	ASSERT_EQ(0, rename(file2_s1d2, file1_s2d3));
> +	/*
> +	 * Modifying the layout is now denied because the second layer does not
> +	 * handle REFER, which is always denied by default.
> +	 */
> +	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
> +	ASSERT_EQ(EXDEV, errno);
>
>  	/* Without REFER source, EACCES wins over EXDEV. */
>  	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
>
> base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
> --
> 2.37.2
>

--
