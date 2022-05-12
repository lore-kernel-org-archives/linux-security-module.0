Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E0C433F5
	for <linux-security-module@archiver.kernel.org>; Thu, 12 May 2022 17:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356943AbiELRT0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 May 2022 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356941AbiELRTT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 May 2022 13:19:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0851E26AD8D
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652375956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEFXUtbClHFFmeWShgFw8vJilTye35f28JoIGyS8/V0=;
        b=PW/pWgpLsParDTloa5Bo+H5FCUyjPR68E4gX13hTVgMxEYzFq7TyyIhDMywem0yMjwMPh+
        ixw5+MX2yr4Ctbz2Y4WE1rNa6ZqiAhU12r2N0uBg2TYTDAWJOFpEPWnyY/ohqNRhoqki43
        BsC7PZvcjyWtZwWNrQatAMjZ2Whs7bY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-RIKyJZd-NuuqpyQvDShkeg-1; Thu, 12 May 2022 13:19:15 -0400
X-MC-Unique: RIKyJZd-NuuqpyQvDShkeg-1
Received: by mail-qv1-f69.google.com with SMTP id m8-20020a0c9d08000000b00456549a0589so5030670qvf.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 May 2022 10:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oEFXUtbClHFFmeWShgFw8vJilTye35f28JoIGyS8/V0=;
        b=JF9HPfuh+dG9wzgdZe3Q4hKxT8h3VanmRGaKREpRG7MQVREY561+XMObGmiEi28m/V
         hsQ05LWxRyKDHVt8tGplsVP+Wra7buZPVRSHA8boaJge5CR7cOahHVx5bzwaVJN7xp0D
         +d9FtYKBr63a6Wd2ZF3hBIcDdIqb1fundNSX0Cxaexd8TUn5vfu8hM9a7u/JBehXlcX4
         cbADIvRO1/7f2Sr8Di+wgIWaLzk7RnybpqfIoKlDraYrVOyUo0kOBbEE7RvRQl2Js9oT
         1Z5iQ52S6kUZuKsOunNggeb70MpD1bwnXVvuVCFMpvodJFutoC+25OtDY7YgPTJyaN2P
         XEQA==
X-Gm-Message-State: AOAM5324ratJnhGboxacrXvejC7x/+ASyDCZF7yZ2E5Ig7UeIiy1QAvh
        MslpBcY48WdiCqgfuXVc99YNKNFnJ2ZRQSTgyF0Vs2uxi9BxqYkOjIXxTLZ/Y1bAYCTCpsORzdZ
        /zyzqwRmxDauW5xY6t8B85uy6nZBgYAUS9NQ=
X-Received: by 2002:a05:620a:c43:b0:67d:f048:f5e9 with SMTP id u3-20020a05620a0c4300b0067df048f5e9mr707664qki.281.1652375954900;
        Thu, 12 May 2022 10:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykQ0VJO8iqsfXZLVTIsX7tPq3/5ge1HQXrF4uHNL4asswoVlbtihDk13sRBvxtNiaNVD0epg==
X-Received: by 2002:a05:620a:c43:b0:67d:f048:f5e9 with SMTP id u3-20020a05620a0c4300b0067df048f5e9mr707646qki.281.1652375954576;
        Thu, 12 May 2022 10:19:14 -0700 (PDT)
Received: from localhost ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id j126-20020a375584000000b006a103949657sm27998qkb.38.2022.05.12.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:19:13 -0700 (PDT)
Date:   Thu, 12 May 2022 13:19:12 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
Message-ID: <Yn1BkO4t+CXR0nzk@redhat.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YnwioaRiVmYevo8i@google.com>
MIME-Version: 1.0
In-Reply-To: <YnwioaRiVmYevo8i@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 11 2022 at  4:54P -0400,
Matthias Kaehlcke <mka@chromium.org> wrote:

> Alasdar/Mike, I'd be interested in your take on adding these functions
> to verity/DM, to get an idea whether this series has a path forward to
> landing upstream.

I'll be reviewing your patchset now. Comments inlined below.

> On Wed, May 04, 2022 at 12:54:17PM -0700, Matthias Kaehlcke wrote:
> > LoadPin limits loading of kernel modules, firmware and certain
> > other files to a 'pinned' file system (typically a read-only
> > rootfs). To provide more flexibility LoadPin is being extended
> > to also allow loading these files from trusted dm-verity
> > devices. For that purpose LoadPin can be provided with a list
> > of verity root digests that it should consider as trusted.
> > 
> > Add a bunch of helpers to allow LoadPin to check whether a DM
> > device is a trusted verity device. The new functions broadly
> > fall in two categories: those that need access to verity
> > internals (like the root digest), and the 'glue' between
> > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > the glue functions.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v3:
> > - none
> > 
> > Changes in v2:
> > - none
> > 
> >  drivers/md/Makefile               |  6 +++
> >  drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
> >  drivers/md/dm-verity-target.c     | 33 +++++++++++++
> >  drivers/md/dm-verity.h            |  4 ++
> >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> >  5 files changed, 150 insertions(+)
> >  create mode 100644 drivers/md/dm-verity-loadpin.c
> >  create mode 100644 include/linux/dm-verity-loadpin.h
> > 
> > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > index 0454b0885b01..e12cd004d375 100644
> > --- a/drivers/md/Makefile
> > +++ b/drivers/md/Makefile
> > @@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
> >  dm-mod-objs			+= dm-ima.o
> >  endif
> >  
> > +ifeq ($(CONFIG_DM_VERITY),y)
> > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > +dm-mod-objs			+= dm-verity-loadpin.o
> > +endif
> > +endif
> > +

Why are you extending dm-mod-objs?  Why not dm-verity-objs?

> >  ifeq ($(CONFIG_DM_VERITY_FEC),y)
> >  dm-verity-objs			+= dm-verity-fec.o
> >  endif
> > diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> > new file mode 100644
> > index 000000000000..972ca93a2231
> > --- /dev/null
> > +++ b/drivers/md/dm-verity-loadpin.c
> > @@ -0,0 +1,80 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/dm-verity-loadpin.h>
> > +
> > +#include "dm.h"
> > +#include "dm-verity.h"
> > +
> > +static struct list_head *trusted_root_digests;
> > +
> > +/*
> > + * Sets the root digests of verity devices which LoadPin considers as trusted.
> > + *
> > + * This function must only be called once.
> > + */
> > +void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests)
> > +{
> > +	if (!trusted_root_digests)
> > +		trusted_root_digests = digests;
> > +	else
> > +		pr_warn("verity root digests trusted by LoadPin are already set!!!\n");
> > +}

Would prefer you set a DM_MSG_PREFIX and use DMWARN() instead.

You never explicitly initialize trusted_root_digests to NULL.

Also, I'll have to look at the caller(s), but without locking this
branching is racey.

> > +
> > +static bool is_trusted_verity_target(struct dm_target *ti)
> > +{
> > +	u8 *root_digest;
> > +	unsigned int digest_size;
> > +	struct trusted_root_digest *trd;
> > +	bool trusted = false;
> > +
> > +	if (!dm_is_verity_target(ti))
> > +		return false;
> > +
> > +	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> > +		return false;
> > +
> > +	list_for_each_entry(trd, trusted_root_digests, node) {
> > +		if ((trd->len == digest_size) &&
> > +		    !memcmp(trd->data, root_digest, digest_size)) {
> > +			trusted = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	kfree(root_digest);
> > +
> > +	return trusted;
> > +}
> > +
> > +/*
> > + * Determines whether a mapped device is a verity device that is trusted
> > + * by LoadPin.
> > + */
> > +bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
> > +{
> > +	int srcu_idx;
> > +	struct dm_table *table;
> > +	unsigned int num_targets;
> > +	bool trusted = false;
> > +	int i;
> > +
> > +	if (!trusted_root_digests || list_empty(trusted_root_digests))
> > +		return false;

Again, where is the locking to protect trusted_root_digests?

> > +	table = dm_get_live_table(md, &srcu_idx);
> > +	num_targets = dm_table_get_num_targets(table);
> > +	for (i = 0; i < num_targets; i++) {
> > +		struct dm_target *ti = dm_table_get_target(table, i);
> > +
> > +		if (is_trusted_verity_target(ti)) {
> > +			trusted = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	dm_put_live_table(md, srcu_idx);
> > +
> > +	return trusted;
> > +}
> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > index 80133aae0db3..6f07b849fcb2 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/reboot.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/string.h>
> >  
> >  #define DM_MSG_PREFIX			"verity"
> >  
> > @@ -1310,6 +1311,38 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >  	return r;
> >  }
> >  
> > +/*
> > + * Check whether a DM target is a verity target.
> > + */
> > +bool dm_is_verity_target(struct dm_target *ti)
> > +{
> > +	return ti->type->module == THIS_MODULE;
> > +}
> > +EXPORT_SYMBOL_GPL(dm_is_verity_target);
> > +
> > +/*
> > + * Get the root digest of a verity target.
> > + *
> > + * Returns a copy of the root digest, the caller is responsible for
> > + * freeing the memory of the digest.
> > + */
> > +int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned int *digest_size)
> > +{
> > +	struct dm_verity *v = ti->private;
> > +
> > +	if (!dm_is_verity_target(ti))
> > +		return -EINVAL;
> > +
> > +	*root_digest = kmemdup(v->root_digest, v->digest_size, GFP_KERNEL);
> > +	if (*root_digest == NULL)
> > +		return -ENOMEM;
> > +
> > +	*digest_size = v->digest_size;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dm_verity_get_root_digest);
> > +
> >  static struct target_type verity_target = {
> >  	.name		= "verity",
> >  	.version	= {1, 8, 0},
> > diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> > index 4e769d13473a..c832cc3e3d24 100644
> > --- a/drivers/md/dm-verity.h
> > +++ b/drivers/md/dm-verity.h
> > @@ -129,4 +129,8 @@ extern int verity_hash(struct dm_verity *v, struct ahash_request *req,
> >  extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
> >  				 sector_t block, u8 *digest, bool *is_zero);
> >  
> > +extern bool dm_is_verity_target(struct dm_target *ti);
> > +extern int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest,
> > +				     unsigned int *digest_size);
> > +
> >  #endif /* DM_VERITY_H */
> > diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
> > new file mode 100644
> > index 000000000000..12a86911d05a
> > --- /dev/null
> > +++ b/include/linux/dm-verity-loadpin.h
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_DM_VERITY_LOADPIN_H
> > +#define __LINUX_DM_VERITY_LOADPIN_H
> > +
> > +#include <linux/list.h>
> > +
> > +struct mapped_device;
> > +
> > +struct trusted_root_digest {
> > +	u8 *data;
> > +	unsigned int len;
> > +	struct list_head node;
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
> > +void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests);
> > +bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md);
> > +#else
> > +static inline void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests) {}
> > +static inline bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> > +#endif /* __LINUX_DM_LOADPIN_H */
> > -- 
> > 2.36.0.464.gb9c8b46e94-goog
> > 
> 

