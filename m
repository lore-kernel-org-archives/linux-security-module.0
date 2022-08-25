Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D56CECAAA2
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Aug 2022 22:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiHYW1S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244419AbiHYW1R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Aug 2022 18:27:17 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B19C651C
        for <linux-security-module@vger.kernel.org>; Thu, 25 Aug 2022 15:27:15 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MDHdY46DyzMptrQ;
        Fri, 26 Aug 2022 00:27:13 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MDHdY06fdzlh8TB;
        Fri, 26 Aug 2022 00:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661466433;
        bh=uFkTvXPeUXEsVbl3i3c2HKNA4IToOYqss3HuM94XQPA=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=kgSZtdTMzXiI9kKdbkvsUsl47CqqFVLgxz4RoIXbHgQhtiAZt91Qeyv0I5tyCb5vH
         SopsMOCyr9PI7TuDJmerSm3JUABFKxJcvB2ENEp5Ri5mlI2l48UJDPW+vHLfEy0BKs
         vum9HG4HGzkSjQf3rgjtPQGasjDLNrMx9MRRAFmw=
Message-ID: <bd085c93-5814-e701-bdcb-54e9d5fbe8db@digikod.net>
Date:   Fri, 26 Aug 2022 00:27:12 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <20220823144123.633721-1-mic@digikod.net> <Ywf0okWNl4gRXTYL@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
In-Reply-To: <Ywf0okWNl4gRXTYL@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 26/08/2022 00:16, Günther Noack wrote:
> On Tue, Aug 23, 2022 at 04:41:23PM +0200, Mickaël Salaün wrote:
>> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
>> globally denied-by-default access right.  Indeed, this lifted an initial
>> Landlock limitation to rename and link files, which was initially always
>> denied when the source or the destination were different directories.
>>
>> This led to an inconsistent backward compatibility behavior which was
>> only taken into account if no domain layer were using the new
>> LANDLOCK_ACCESS_FS_REFER right.  However, in a scenario where layers are
>> using the first and the second Landlock ABI (i.e.
>> LANDLOCK_ACCESS_FS_REFER or not), the access control behaves like if all
>> domains were handling LANDLOCK_ACCESS_FS_REFER with their rules
>> implicitely allowing such right.  Indeed, the not-handled access rights
>> were allowed, which should not be the case for LANDLOCK_ACCESS_FS_REFER.
>> It should be noted that this bug only allowed safe renames or links, but
>> no privilege escalation because the LANDLOCK_ACCESS_FS_REFER properties
>> were still enforced (e.g. only allowed to move a file according to all
>> other access rights, and if it doesn't give more Landlock accesses).
>>
>> This change adds an ACCESS_INITIALLY_DENIED list of denied-by-default
>> rights, which (only) contains LANDLOCK_ACCESS_FS_REFER.  All domains are
>> treated as if they are also handling this list, but without modifying
>> their fs_access_masks field, which enables correct domain audit.
>>
>> A side effect is that the errno code returned by rename(2) or link(2)
>> *may* be changed from EXDEV to EACCES according to the enforced
>> restrictions.  Indeed, we now have the mechanic to identify if an access
>> is denied because of a required right (e.g. LANDLOCK_ACCESS_FS_MAKE_REG,
>> LANDLOCK_ACCESS_FS_REMOVE_FILE) or if it is denied because of missing
>> LANDLOCK_ACCESS_FS_REFER rights.  This may result in different errno
>> codes than for the initial Landlock version, but this approach is better
>> for rename/link compatibility reasons, and it wasn't possible before
>> (hence no backport to ABI v1).  The layout1.rename_file test reflects
>> this change.
>>
>> Add the layout1.refer_denied_by_default* tests to check that the
>> behavior of a ruleset not handling LANDLOCK_ACCESS_FS_REFER (ABI v1) is
>> unchanged even if another layer handles LANDLOCK_ACCESS_FS_REFER (i.e.
>> ABI v1 precedence).  Make sure rule's absolute access rights are correct
>> by testing with and without a matching path.
>>
>> Extend layout1.inval tests to check that a denied-by-default access
>> right is not necessarily part of a domain's handled access rights.
>>
>> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
>> Cc: Günther Noack <gnoack3000@gmail.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220823144123.633721-1-mic@digikod.net
>> ---
>>   security/landlock/fs.c                     |  28 +++--
>>   tools/testing/selftests/landlock/fs_test.c | 133 +++++++++++++++++++--
>>   2 files changed, 143 insertions(+), 18 deletions(-)
>>
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index ec5a6247cd3e..0cf484e89f68 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -149,6 +149,15 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>>   	LANDLOCK_ACCESS_FS_READ_FILE)
>>   /* clang-format on */
>>
>> +/*
>> + * All access rights that are denied by default whether they are handled or not
>> + * by a ruleset/layer.
>> + */
>> +/* clang-format off */
>> +#define ACCESS_INITIALLY_DENIED ( \
>> +	LANDLOCK_ACCESS_FS_REFER)
>> +/* clang-format on */
>> +
>>   /*
>>    * @path: Should have been checked by get_path_from_fd().
>>    */
>> @@ -167,7 +176,9 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>>   		return -EINVAL;
>>
>>   	/* Transforms relative access rights to absolute ones. */
>> -	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~ruleset->fs_access_masks[0];
>> +	access_rights |=
>> +		LANDLOCK_MASK_ACCESS_FS &
>> +		~(ruleset->fs_access_masks[0] | ACCESS_INITIALLY_DENIED);
>>
>>   	object = get_inode_object(d_backing_inode(path->dentry));
>>   	if (IS_ERR(object))
>>   		return PTR_ERR(object);
>> @@ -277,7 +288,7 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
>>   static inline access_mask_t
>>   get_handled_accesses(const struct landlock_ruleset *const domain)
>>   {
>> -	access_mask_t access_dom = 0;
>> +	access_mask_t access_dom = ACCESS_INITIALLY_DENIED;
>>   	unsigned long access_bit;
>>
>>   	for (access_bit = 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
>> @@ -316,8 +327,13 @@ init_layer_masks(const struct landlock_ruleset *const domain,
>>
>>   		for_each_set_bit(access_bit, &access_req,
>>   				 ARRAY_SIZE(*layer_masks)) {
>> -			if (domain->fs_access_masks[layer_level] &
>> -			    BIT_ULL(access_bit)) {
>> +			/*
>> +			 * Artificially handles all initially denied by default
>> +			 * access rights.
>> +			 */
>> +			if (BIT_ULL(access_bit) &
>> +			    (domain->fs_access_masks[layer_level] |
>> +			     ACCESS_INITIALLY_DENIED)) {
>>   				(*layer_masks)[access_bit] |=
>>   					BIT_ULL(layer_level);
>>   				handled_accesses |= BIT_ULL(access_bit);
>> @@ -857,10 +873,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>>   					      NULL, NULL);
>>   	}
>>
>> -	/* Backward compatibility: no reparenting support. */
>> -	if (!(get_handled_accesses(dom) & LANDLOCK_ACCESS_FS_REFER))
>> -		return -EXDEV;
>> -
>>   	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
>>   	access_request_parent2 |= LANDLOCK_ACCESS_FS_REFER;
>>
> 
> In this change, you are adding "| ACCESS_INITIALLY_DENIED" to a bunch
> of places in fs.c where a domain->fs_access_masks[...] is read.
> 
> In the documentation for the refer right, it is described with:
> 
>    This is also the only access right which is always considered
>    handled by any ruleset in such a way that reparenting a file
>    hierarchy is always denied by default.
> 
> Naive question: Is anything keeping us from also implementing it in
> that way? We could pretend early during ruleset creation that the
> caller had asked to also handle the "refer" right. Then we would just
> have the "refer" bit set on every domain->fs_access_masks[...] entry.
> 
> Wouldn't that do the same, without further complicating the access
> check logic in fs.c?

This patch fixes the (absolute) rule access rights, which now always 
forbid LANDLOCK_ACCESS_FS_REFER except when it is explicitely allowed 
when creating a rule. Making all domain handle LANDLOCK_ACCESS_FS_REFER 
was may initial approach but there is two downsides:
- it makes the code more complex because we still want to check that a 
rule allowing LANDLOCK_ACCESS_FS_REFER is legitimate according to the 
ruleset's handled access rights (i.e. ABI v1 != ABI v2);
- it would not allow to identify if the user created a ruleset 
explicitely handling LANDLOCK_ACCESS_FS_REFER or not, which will be an 
issue to audit Landlock (not really possible right now but soon ;) ).

The difference with the current approach is only in the 
get_handled_accesses() and init_layer_masks(), instead of patching the 
ruleset enforcement.


> 
> FWIW, one thing that would happen in this approach would be that users
> could add rules asking to grant the "refer" right on files, on
> rulesets where they have not previously declared it as a "handled"
> right. It's debatable whether that is good API design, but it would
> not do much damage either, and could also be fixed by keeping a copy
> of the originally requested handled_access_fs.

Ah! From my point of view it is not a good API because it is a moving 
one (without notice). Keeping a copy of the originally requested 
handled_access_fs works but consumes data memory for something that can 
be done with the code, hence this solution.
