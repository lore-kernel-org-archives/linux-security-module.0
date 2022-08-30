Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF97ECAAA1
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Aug 2022 20:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiH3UDW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiH3UDD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Aug 2022 16:03:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3405927FCA
        for <linux-security-module@vger.kernel.org>; Tue, 30 Aug 2022 13:01:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id cu2so24445360ejb.0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Aug 2022 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=UGP4efVn65DxvIjnEUm/vxPaWBLKLcrXIj/kgDCpHh4=;
        b=foBMDAoFD4a2LzI6HW8dc9i/H3h9uiUv9KjVfe1aP/7br4Ew61oORo5/cnBWMxGUzr
         Ll2snhCVjWaZtlow4dWd7PtWa3i+5cq4xQND5Hohm/TY77hMcFCbWV2hLlFzZXmeJ5VD
         bSBgRrDitdrGPRLZ/P5dQhYqPOZUny+uaL/MkIetwq4Cgxw/VttuGuaytmvk4IKMVAPX
         Yz5yUglKXCcKYRZ3QxXYfq2TWaFJ/7dWBdLW8GUydz5i6ECGp+sg4Trza8Uipf2dPBsK
         +1uRxVGPgi2InxxLZbqMJmtr7XaLgTCOVNmBbmOTaeBdJtPrXqgrL5+09IUYP0UYCZFy
         WVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=UGP4efVn65DxvIjnEUm/vxPaWBLKLcrXIj/kgDCpHh4=;
        b=lNx4Uy9R6yX+52OiY9nlBvsrHqaU+ulV6WsR2rWkzHBWMMQ94vKsZAOHP6qEtX62hC
         i9vGR22vO97+a3G4Y8axAfYo7JnamPD7H++woCrccmW0fOSRl+STeGkRx3ROxFZmm+oF
         /Q/+ubGIqDIFBToE95I85OJ8ekRxvKQNcTocaVivn8ch/F6jj1HR8QopqCGhKDOL/l7H
         Akeh4KLcqTZSP+Sa/TUJuYbZSEDpp0fhPpNxKRWSe84aOaXEmt6eQemns2UdAAE2g+d1
         eWT3tLnHX2FHT8TsVq0ZKnw0bUw9AWAvGfB/RvRVGi7vxVdiYQW6JiSM16gc8mjXwohI
         WU6g==
X-Gm-Message-State: ACgBeo0exScj/KKz+sBgRF4mvOJu0lJ4msXvC8vT83B48/rAziK9oZmW
        svfDLqJBh3dNt+0ooHzRfccpZ99BS9I=
X-Google-Smtp-Source: AA6agR7HncNc1eg1pCjolPIytbK3b3kVQunzCP1jbErA/L1KTxUzrcvqRc1G5lEXIRqhdtOU5fYX6g==
X-Received: by 2002:a17:907:2701:b0:741:51eb:2338 with SMTP id w1-20020a170907270100b0074151eb2338mr11067674ejk.501.1661889701271;
        Tue, 30 Aug 2022 13:01:41 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id l22-20020a056402125600b0044602e3dcd7sm7794162edw.95.2022.08.30.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:01:40 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:01:38 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <Yw5sohZpB6a+l2la@nuc>
References: <20220823144123.633721-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823144123.633721-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch looks good to me.


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

I feel it might be a good idea to explain why and how this constant
must be used. In my understanding, ACCESS_INITIALLY_DENIED must be
bitwise-or'd to ruleset->fs_access_masks[...] everytime that it is
being read? (That is at least the case everywhere in fs.c.)

(I still suspect that the layering might be easier to understand if we
already populated fs_access_masks with the 'refer' flag set, but I'm
not feeling that strongly about it if you want to keep it as is.)

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

(Putting this in parenthesis, because it's maybe out of scope for this
code review:

It seems to me that the two nested loops in get_handled_accesses() are
equivalent to doing:

   access_mask_t access_dom = ACCESS_INITIALLY_DENIED;
   size_t i;
   for (i = 0; i < domain->num_layers; i++) {
       access_dom |= domain->fs_access_masks[i];
   }
   return access_dom;

I have my doubts that the early break in the inner loop makes any
difference performance wise when we can replace one of the loops with
bitwise operations?

Even more unrelated thoughts:

In a similar fashion, a lot of the fs.c bit logic could be simplified
by inverting the layer_masks to be a max-layers-sized array of access
masks instead of a max-access-right-sized array of layer masks. I
notice that you have been counting the individual bytes for this
structure in the "refer" patch set though :-/ I wish this was
simpler...

I imagine that walking the path once per layer to unmask the
access_req for each layer was also discussed at the time, but then
discarded? (Is this to protect against concurrent modifications to the
file hierarchy?)

(These remarks are definitely out of scope for this change, they just
came up because I tried to understand all the surrounding code. I
guess I'm still catching up...))

> @@ -857,10 +873,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  					      NULL, NULL);
>  	}
>
> -	/* Backward compatibility: no reparenting support. */
> -	if (!(get_handled_accesses(dom) & LANDLOCK_ACCESS_FS_REFER))
> -		return -EXDEV;

If I understand correctly, this was the place where the logic bug was
- is that correct?

* with one ruleset where handled_access_fs *does not* have refer,
  it returns EXDEV (OK)
* with one ruleset where handled_access_fs *does* have refer,
  it continues (OK)
* with two ruleset where one does and the other does not have refer,
  it acts like refer is handled and continues without EXDEV
  but it should have returned EXDEV because that was the strict behaviour of
  the "v1"-style ruleset.

I think it's better to handle the V1 and V2 calls in a more unified
way, good to remove this backwards compatibility check.

>  	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
>  	access_request_parent2 |= LANDLOCK_ACCESS_FS_REFER;
>
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

Do I understand correctly that these changes are the cases where we
were previously hitting the early -EXDEV return (the one which I
commented on above)? So now a V1-style Landlock ruleset (without refer
in handled_access_fs) will result in errors that are in line with what
would happen if the refer right had been part of handled_access_fs in
the same ruleset?

This is a slight API change, but only in error codes and hopefully
within reason. I hope the backwards compatibility policy is a bit
forgiving in such cases? (Landlock does not have that many users yet,
after all.)

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

*optional* We could use EXPECT_EQ for the rename{,at2} checks.

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

These are just test style comments, so non-blockers in my mind; I find
the interface to the refer_denied_by_default helper function difficult
and it required a bit of jumping back and forth to make sense of it. I
find it often useful to use an approach where each test helper only
spans one of the test phases (set up / exercise / assert) - that helps
to keep the overall test structure in that set up / exercise / assert
form.

I imaginge that these tests could in principle look roughly like this:

TEST_F_FORK(layout1, refer_denied_by_default1)
{
	ASSERT_EQ(0, landlock_restrict_fs(LANDLOCK_ACCESS_FS_REFER, (struct rule[]){
        	{
                	.path = "superdir";
                        .access = LANDLOCK_ACCESS_FS_REFER,
                },
                {},
        }));
        EXPECT_EQ(0, test_rename("superdir/file1", "superdir/subdir/file1"));

	ASSERT_EQ(0, landlock_restrict_fs(LANDLOCK_ACCESS_FS_EXECUTE, (struct rule[]){
        	{
                	.path = "superdir";
                        .access = LANDLOCK_ACCESS_FS_EXECUTE,
                },
                {},
        }));
        EXPECT_EQ(EXDEV, test_rename("superdir/file2", "superdir/subdir/file2"));
}

Small optional remark on the side: I find the test scenario has a
slightly better punchline when turning around the order in which the
two layers are installed - because that also worked prior to this fix,
and it's more clearly wrong, as it was possible to do *more*
operations after installing the second layer.

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
