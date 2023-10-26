Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DE1C25B6B
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Oct 2023 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjJZIt3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Oct 2023 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbjJZIt2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Oct 2023 04:49:28 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6123E18D
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 01:49:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SGJzg4KYkz9y4T6
        for <linux-security-module@vger.kernel.org>; Thu, 26 Oct 2023 16:36:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3wZICKDpld_vxAg--.2890S2;
        Thu, 26 Oct 2023 09:49:11 +0100 (CET)
Message-ID: <179849e189257e1e1a8af88848114982e663f599.camel@huaweicloud.com>
Subject: Re: [PATCH] lsm: drop LSM_ID_IMA
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Thu, 26 Oct 2023 10:49:03 +0200
In-Reply-To: <CAHC9VhQ9D1EB9mSRakrCQ9rKUC+Pi2in6MLbZsm6Y3vA5BkweQ@mail.gmail.com>
References: <20231018215032.348429-2-paul@paul-moore.com>
         <72a92e27855af2291273209d328e1b79f3b61663.camel@huaweicloud.com>
         <1764a96f-6d24-4585-a24b-667a5ea075c3@schaufler-ca.com>
         <f47097f8-3391-42a7-b8b5-81e1be2d8e68@huaweicloud.com>
         <88f4f464-ac09-4c93-95f4-fe4546b78a08@schaufler-ca.com>
         <CAHC9VhSVcfsCM6GjxJrSPCXV3PYRahXJi5HiNyKGCt8f_fOpmA@mail.gmail.com>
         <93b2ea72-a9b1-4d50-bc4a-3d60d91dd44b@huaweicloud.com>
         <CAHC9VhQ3kKGWNUx=+vEZ58CUJo2YKVu4rrOjE+w5x9jKnP9MWA@mail.gmail.com>
         <fb6e908e-55b4-4264-a50e-31de4ce538f5@huaweicloud.com>
         <3e35d87e-bde0-4276-ae3e-761ee1d02c4a@huaweicloud.com>
         <CAHC9VhQ9D1EB9mSRakrCQ9rKUC+Pi2in6MLbZsm6Y3vA5BkweQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwC3wZICKDpld_vxAg--.2890S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18GFW5XFWUCrW3Aw1DKFg_yoW5tFyDpr
        W8tayUKF4Dtr1jkryvyF1rA34UKrZ5Xr17Xr98Jw1UX34qyryUXr1xAr4Uua4UGr40kw1j
        yF4aqry3ZryDA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5GJTgABsi
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2023-10-25 at 22:54 -0400, Paul Moore wrote:
> On Wed, Oct 25, 2023 at 10:37 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On 10/25/2023 4:06 PM, Roberto Sassu wrote:
> > > On 10/25/2023 3:14 PM, Paul Moore wrote:
> > > > On Wed, Oct 25, 2023 at 6:36 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > On 10/24/2023 11:18 PM, Paul Moore wrote:
> > > > > > On Mon, Oct 23, 2023 at 11:48 AM Casey Schaufler
> > > > > > <casey@schaufler-ca.com> wrote:
> > > > > > > On 10/23/2023 8:20 AM, Roberto Sassu wrote:
> > > > > > > > On 10/20/2023 11:56 PM, Casey Schaufler wrote:
> > > > > > > > > On 10/19/2023 1:08 AM, Roberto Sassu wrote:
> > > > > > > > > > On Wed, 2023-10-18 at 17:50 -0400, Paul Moore wrote:
> > > > > > > > > > > When IMA becomes a proper LSM we will reintroduce an appropriate
> > > > > > > > > > > LSM ID, but drop it from the userspace API for now in an effort
> > > > > > > > > > > to put an end to debates around the naming of the LSM ID macro.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > > > > > > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > > > 
> > > > > > > > > > This makes sense according to the new goal of making 'ima' and
> > > > > > > > > > 'evm' as
> > > > > > > > > > standalone LSMs.
> > > > > > > > > > 
> > > > > > > > > > Otherwise, if we took existing LSMs, we should have defined
> > > > > > > > > > LSM_ID_INTEGRITY, associated to DEFINE_LSM(integrity).
> > > > > > > > > > 
> > > > > > > > > > If we proceed with the new direction, I will add the new LSM IDs as
> > > > > > > > > > soon as IMA and EVM become LSMs.
> > > > > > > > > 
> > > > > > > > > This seems right to me. Thank You.
> > > > > > > > 
> > > > > > > > Perfect! Is it fine to assign an LSM ID to 'ima' and 'evm' and keep
> > > > > > > > the 'integrity' LSM to reserve space in the security blob without LSM
> > > > > > > > ID (as long as it does not register any hook)?
> > > > > > > 
> > > > > > > That will work, although it makes me wonder if all the data in the
> > > > > > > 'integrity' blob
> > > > > > > is used by both IMA and EVM. If these are going to be separate LSMs
> > > > > > > they should probably
> > > > > > > have their own security blobs. If there is data in common then an
> > > > > > > 'integrity' blob can
> > > > > > > still makes sense.
> > > > > > 
> > > > > > Users interact with IMA and EVM, not the "integrity" layer, yes?  If
> > > > > > so, I'm not sure it makes sense to have an "integrity" LSM, we should
> > > > > > just leave it at "IMA" and "EVM".
> > > > > 
> > > > > The problem is who reserves and manages the shared integrity metadata.
> > > > > For now, it is still the 'integrity' LSM. If not, it would be IMA or EVM
> > > > > on behalf of the other (depending on which ones are enabled). Probably
> > > > > the second would not be a good idea.
> > > > 
> > > > I'm not certain that managing kernel metadata alone necessitates a LSM
> > > > ID token value.  Does "integrity" have any user visible "things" that
> > > > it would want to expose to userspace?
> > > 
> > > No, it doesn't. I already moved the LSM hook registration to 'ima' and
> > > 'evm'. Also the old 'integrity' initialization is done by 'ima' and 'evm'.
> > > 
> > > DEFINE_LSM(integrity) exists only to reserve space in the security blob
> > > and to provide the security blob offset to the get/set functions.
> > > 
> > > Maybe I send the patch set, so that you get a better idea.
> > 
> > Uhm, we should have updated security.c and removed:
> > 
> >          (IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> 
> With LSM_CONFIG_COUNT only being used inside security_add_hooks() I
> believe you are correct.  Do you want to send a patch against
> lsm/dev-staging?

Yes, will do.

Roberto

