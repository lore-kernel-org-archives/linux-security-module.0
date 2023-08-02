Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6FC04A94
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Aug 2023 22:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjHBWgQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHBWgP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Aug 2023 18:36:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DB18B;
        Wed,  2 Aug 2023 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=B8NL8ZPj4lVJOEIOnl2j4qecqLNEz+fPjufrYvydDJQ=; b=AO2kXk7HBxbAUBw1gm9E0J8qK3
        x1/pF6CRfMdjbGYO/2gr0X+gLG72kkPmvpu3KUtrQaN5MRCMIsfTds3PMSgxMdz16fzWj4hp4dE2P
        1XjfEHuo2YQTOyhuYWyUXzz85jj575hnqWn5tTPwmhJTrCUwt3KkgfprbAWNCTVUt+Ilp+AkfU3P3
        hgF83CaFSb97Y1bnGDjqLZv1YNEU4Xkn4qjW7aaqahafmLS8VRAp0U+yr3bmndDUAeVDisILGvhUm
        rRkaRggujiViHaReIVwai7afXDXx82CToqAYTR0YP8ZUcl7D8f/oIMFZXqVxVENO/xc8hviDLTfvz
        e0I/83hg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRKRs-0062ly-22;
        Wed, 02 Aug 2023 22:36:08 +0000
Message-ID: <c1f1b7b7-fb2f-cd03-d962-70979082c1b4@infradead.org>
Date:   Wed, 2 Aug 2023 15:36:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: ANN: new LSM guidelines
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-doc@vger.kernel.org
References: <CAHC9VhRsxARUsFcJC-5zp9pX8LWbKQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com>
 <4708afda-8867-735a-2f55-ca974e76cc9c@schaufler-ca.com>
 <CAHC9VhTepATGki_8_nyUcmCCvJ2hpLO4bWFhF-gJ3CQceEBMfA@mail.gmail.com>
 <CAHC9VhQ9EfH5sb85+uwyB726iDNR47k=sfr0zBCENz=-PerR9A@mail.gmail.com>
 <20230802.doki9xoTh0ai@digikod.net>
 <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHC9VhSb+=JF7GJ-98DX_3NO2eSLeurXO+w4xcgHuXFh6HqWVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

On 8/2/23 14:56, Paul Moore wrote:
> On Wed, Aug 2, 2023 at 2:38 PM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> I like this guideline. I guess this is your goal and I think it should
>> be part of Documentation/security/lsm.rst (and move the introduction
>> part of lsm-development.rst into lsm.rst) and get a few SoB.
> 
> Thanks for the review and comments.  Responses below, but I'll post an
> updated guidance doc in just a bit incorporating your feedback as well
> as those of a few others who sent me comments off-list.
> 
> As far as moving this guidance into Documentation/security, yes, that
> is the ultimate goal.  In fact I have a todo item to go through all of
> Documentation/security and give it a good cleaning/review/edit,
> although please don't expect that anytime soon :/
> 
>> On Tue, Aug 01, 2023 at 06:47:12PM -0400, Paul Moore wrote:
>>> On Fri, Jul 7, 2023 at 6:02 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Thu, Jul 6, 2023 at 8:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 7/6/2023 1:42 PM, Paul Moore wrote:
>>>>>> Hello all,
>>>>>>
>>>>>> With some renewed interest in submitting new LSMs including in the
>>>>>> upstream Linux Kernel I thought it might be a good idea to document
>>>>>> some of our longstanding guidelines around submitting new LSMs.  I'm
>>>>>> posting this mostly as a FYI for those who are working on new LSM
>>>>>> submissions, but also to solicit feedback from everyone on the list
>>>>>> regarding what we should ask of new LSMs.  If you think I'm missing
>>>>>> something important, or believe I've added an unfair requirement,
>>>>>> please let me know.
>>>>>>
>>>>>> I've added the guidelines to the README.md at the top of the LSM tree,
>>>>>> but to make life easier for those reviewing the guidelines I'm
>>>>>> copy-n-pasting them below ...
>>>
>>> I've updated the README.md doc based on the feedback, and copied the
>>> two new sections below for easier review.  If anyone has any
>>> additional feedback or concerns, please let me know.
>>>
>>> ## New LSM Hook Guidelines
>>>
>>> While LSM hooks are generally considered outside of the Linux Kernel's stable
>>
>> Why "generally"?
> 
> Good point, I'll remove that.
> 
>>> API promise, due to the nature of the LSM hooks we try to minimize changes to
>>> the hooks.  With that in mind, we have the following requirements for new LSM
>>> hooks:
>>>
>>> * Hooks should be designed to be LSM agnostic.  While it is possible that only
>>> one LSM might implement the hook at the time of submission, the hook's behavior
>>> should be generic enough that other LSMs could provide a meaningful
>>> implementation.
>>
>> We should also avoid falling in the other extreme which is to add
>> different argument just-in-case. For instance, there is no need to add a
>> "flags" argument to a kernel API if there is no flag for now, especially
>> if there are only a few users of this hook.
>>
>> I would say that we want generic-as-possible hooks (e.g. well
>> positioned) but not with useless arguments.
> 
> Agreed, although I think that's hard to properly describe that in a
> sentence or two.  It's going to be impossible to capture every
> requirement in this doc (I added a new paragraph explaining this in
> the latest revision), so I think we can just leave this as-is for now.
> 
> If it does become a problem we can work a bit harder on describing
> what makes a "good" LSM hook.
> 
>>> * There must be at least one LSM implementation of the hook included in the
>>> submission to act as a reference for additional LSM implementations.  The
>>> reference implementation must be for one of the upstream, in-kernel LSMs; while
>>> the BPF LSM is an upstream LSM, it's nature precludes it from being eligible as
>>> one of the in-kernel LSMs.
>>
>> To avoid misunderstanding, I think it would be better and more generic
>> to focus on the out-of-tree nature of hook implementations.  We might
>> also want to give some pointers for the reason(s) why out-of-tree LSMs
>> use cases are not supported.
> 
> I'm open to new language here if you have some particular wording in mind?
> 
>>> ## New LSM Guidelines
>>>
>>> Historically we have had few requirements around new LSM additions, with
>>> Arjan van de Ven being the first to describe a basic protocol for accepting new
>>> LSMs into the Linux Kernel.  In an attempt to document Arjan's basic ideas and
>>> update them for modern Linux Kernel development, here are a list of
>>> requirements for new LSM submissions:
>>
>> If we go for a kernel documentation patch, it might be better to put
>> most of this historic paragraph into the patch description.
> 
> Agree.
> 
> I was looking for the original comments from Arjan but couldn't find
> them in an archive anywhere, if anyone has a pointer it would be great
> to share that.

Are you referring to either of these?

https://lore.kernel.org/all/20071026141358.38342c0f@laptopd505.fenrus.org/

https://lore.kernel.org/lkml/20071024191933.53094b81@laptopd505.fenrus.org/

-- 
~Randy
