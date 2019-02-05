Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB3C282CC
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C1D2083B
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 20:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mcnyRb9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfBEUE2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:04:28 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:44382
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727060AbfBEUE2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 15:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1549397067; bh=VvPwejrHt0MsKfAYAGREzd7uLtSoSsj+svzkt0PMpwY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mcnyRb9GrUzXp3fMuUTVGr1lAKr7ykLnR9bKUQESGb8bjN4oVAcu2xkBbfsYNmhyhzB5kayMHmk0cfuip75mTafBdGaseMCybuj2/D0Q/TYghc+STWl5YHRA/iLYXeJNyq1JQhO2Eocsuvi+9SW5cImvsELwIHlq5O5HqisfsGTyqKxmpdDQ1pn5oi/JwGwW+74NLHrNjxX2uI6d76W42K1Yzi2hVqq8aPWwJfJnzuYgVG+ozoh7lmdhuLwNedHbl9EDnvOWLp+S8OkEEZ/heyMVMk+0+HL9ODwDrAZb9dphUSc4WADWjffGZNuhswSR6QZ5lUeH1uoA+O9FRzvuVg==
X-YMail-OSG: GGEr0DkVM1kAf7wVtR3lD9zVZ6hbGEdevvOZmxFB5d47SDgmAuAtJMIyfwa50LR
 QRAHI6RcX_kJq2ibY9.ZPAFZlQSH_PdWoL1PvB6sqzpjwEj9D8.tK2FxpcTW_JxNna4.Kg7rEKkj
 1fv34fKLJB1Qxz3Cfkqd2n8YOSrQqKnUKfjIjI_8hfYJycoDPAFpVDltS.e4zr5HLtcJOXTvXCP4
 e.oHO6YzQaCCiAw.LMsJ0gcAcFkbO925tKEIyQ2JE_PUSUjBplyT9WLGffJC6Eye5WAbPFLGErA.
 06b880wVRu2RdUC4yxfVwfDsPElC6.7ubiDqZ46FXQZPvNO74VzWIjun.27nsCZA.Ux_jHhN0rai
 VwvB8gYojt8wis7s7R3rWyTPRaY4Hge3ZyPcQYWQsdwJ8hgxOaoE7jDPgq0ipOdfXi_npKxgsPVC
 R3Q_iEje.czHGy3Ti0T1aom8qKDThaImg.AA_fJlShRvWRhfHIBsK4O04Jn90Wjzu14lpp69L6x9
 iOR4ctxTk3JhJcFtXJa3ivW64admFZybBxm_JeiG0vG.WL.I32PKZKkaetRAm4d9mRDsufJx4SlF
 HsAFWxS59A1UP.SdlAjcNzWFYZ5ab1OO77nYX2AArVt1fkmjQ1TQvtEldTN.s4AmCxcQOc6ITS8U
 yqei95k5dX2euovh_F_DS0wIQ8_ldjfBEq8O7OJ84BjJHkwHy87OCXOutj0rRUg8I4bdNi_bXvQe
 wiQEn1XvEpagriBqshfuajN0AKEeHjM..1OrQZ3Uyt9YhbMyxwBTP6.HoiinrrDRXldyvZ0Bb6oP
 FLcb.MRqgeOev9NAV_gMhVirMPBKvs3r4l2Z0he4.q9dijhOyHOZLPP.MXmZNo5VL687C3I5x0i0
 VyP_50FggYkuneD9kI7_74tdvKPF1pVQjyLZSB7X4W3nSkGLJXAyTnnrB9ztgcFaCJe7jjx4WJZs
 c1kB8Xs5hGOb5NaFzzVuDh2M.ILP3cbMaGpRyqoPmQ_BtHp1pu5eb0PlrarZNptTAi_IXL6tjuAf
 ahzzK7oCs_1Yd8L21O3w3mwLppOpnyzVoQK12NndZjxP49OJ_mk91N5TXK9pj0EzGrpPyzRfKtir
 Zwn7IQrgj_UXLGFvv8nO29sAZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 5 Feb 2019 20:04:27 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8a64583be55525e3db9b036b211462be;
          Tue, 05 Feb 2019 20:04:25 +0000 (UTC)
Subject: Re: New LSM hooks
To:     Paul Moore <paul@paul-moore.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
References: <61766e1d-496e-6a7d-d4b8-52e2c99a78c3@schaufler-ca.com>
 <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a852b633-a777-c353-85cd-c5a1545b4ef9@schaufler-ca.com>
Date:   Tue, 5 Feb 2019 12:04:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQoruL70fUScgYH8WGDP2Hc1=G2j_fjoS24VMUm3xA=aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/5/2019 10:15 AM, Paul Moore wrote:
> On Tue, Feb 5, 2019 at 12:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Full disclosure: This is all about me and my interests.
>>
>> Developers propose new LSM hooks for many reasons. Often,
>> it's in support of an exotic feature such as Infiniband.
>> Sometimes it's because someone got clever when they optimized
>> an otherwise mundane feature and bypassed the usual hooks,
>> as is being proposed for kernfs. Usually there is a particular
>> security module (i.e. SELinux) that is targeted for the hook.
>> In almost all cases a hook is provided for that LSM, but not
>> for any other. In many cases the developers don't even include
>> the LSM email list in the discussions. LSM maintainers find
>> out about the new hooks after the fact.
> I think it is each LSM maintainer's job to ensure that patches which
> affect the LSM hooks, either through modification or addition, are
> CC'd to the LSM list for discussion.  I've tried to be good about
> this, but I'm sure I've missed some over the years.

It's often not the LSM maintainer, but the developer of
the feature that introduces the hook. That's the case that
has been a problem.


>> Prior to 2008, when there was only one LSM, this made perfect
>> sense. Since then, it's been a regular practice justified by
>> the notion that it's the LSM maintainer's option to use the
>> hook or not. That also makes sense in cases where the use is
>> strictly optional, as it is in binder. It does not make sense,
>> however, when a core system facility like kernfs is involved.
> The term "optional" is tricky here.  In all the cases I can think of
> where a LSM hook has been added to an existing bit of kernel
> functionality, the hook has almost always been optional if for no
> other reason than it didn't exist in the previous kernel.  I suppose
> one could argue that there is a functional disparity between LSMs if
> one LSM implements the hook and the others do not, but that is a
> different issue.

Agreed that there's ambiguity about what should be done for
an "optional" feature. If RedHat adds support for a feature
they have every reason to make sure it works correctly with
SELinux and no incentive to implement AppArmor hooks. But is
overlayfs an "optional" feature? If the container developers
who wanted overlayfs only cared about an SELinux environment
does that excuse them from introducing a feature that didn't
work with Smack?

>> I get a double whammy on these new LSM hooks. I have to try
>> to figure out if Smack cares, and if it does, whether to proposed
>> hook will solve the problem for Smack. Because Smack uses
>> xattrs and process attributes differently from SELinux there are
>> often problems with hooks that are provided with only an SELinux
>> implementation. I also have to work out how the new hook will
>> work in the stacked security module case. There are some existing
>> hooks that are a special challenge there, and when a new hook is
>> proposed that does the same kind of things (e.g. use of secid,
>> secctx or list of xattrs) without considering the consequences
>> for other modules.
> Once again, I think it is important to CC the LSM list on these sorts
> of patchsets, and to get the patch author to consider other LSMs, but
> I think asking the original author to preemptively add support to each
> LSM for every new addition is too high a bar.

Two edged sword. If someone introduced an LSM that worked
with btrfs but broke ext4 and xfs it wouldn't be likely to
make it upstream. I wouldn't expect the developer who wants
to introduce a new hook to provide all the LSM versions, but
I would like that developer to work with the LSM maintainers
before the patch is submitted.

>   I would encourage the
> individual LSMs (both maintainers and contributors) to work with patch
> authors in a constructive manner to add support for new hooks when
> they make sense for the given LSM.

Yes.

>> What do I want, I hear you cry? I want some sanity in the way
>> LSM hooks are introduced. I want some standards or conventions
>> on what is appropriate to pass into and out of LSM hooks. I
>> want push back on special purpose hooks that are required to
>> fix the deficiencies of a filesystem or bizarre hardware
>> implementation. I want to stop spending all my time trying to
>> deal with new, crazy LSM hooks. There are enough old ones to
>> keep me entertained, thank you very much.
> Yeah, good luck with that.

Hey, if you don't play, you can't win. ;)

> I think trying to legislate this too much
> is a sure path to failure.

There's not doubt that "too much" legislation would be a problem.
Right now, we have *no* guidance or guidelines.


> Our saving grace is that the LSM hook
> boundary is not a kernel/userspace boundary so we are free to change
> it as needed, we just need to make sure if we change an existing hook
> we don't break any of the existing in-tree LSMs.  We've done this in
> the past without too much problem, even other subsystems have done
> this for us (without much notification to the LSMs) and it has
> generally worked out okay.

Sure, but it's a royal pain to deal with the wild inconsistency
of interfaces we have today. I would like to discourage new
hooks that do things like expose filesystem or network protocol
implementation details to the LSM interface.

> I'm all for increased collaboration between LSMs, e.g. requiring hooks
> changes to CC the LSM list, but I think mandating anything beyond that
> is a fool's errand.

VFS manages this, and I wouldn't call Al a fool.

