Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC972C197A0
	for <linux-security-module@archiver.kernel.org>; Mon, 20 Nov 2023 20:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjKTUEE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 20 Nov 2023 15:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKTUEE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 Nov 2023 15:04:04 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84FBF83;
        Mon, 20 Nov 2023 12:04:00 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7809220B74C0;
        Mon, 20 Nov 2023 12:03:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7809220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700510639;
        bh=A6SV8+Vxjzsp/pV5mLaRvuD4fr7JZuFAvBdg+90xDmY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pNYSfX1m9Hl2rbMOxc06u2RI7ilDkptPlyvwNBGQb0EncEg/MxXhNRvdPW0dKwJpm
         F7+5K5MWD7kkowiIAV23a09KfjxG77s9WIOQy5SD7oyO+kDvhtj6tVUkb2ogZxgPXd
         50ImHsEg/iwBvwN7dbDSnfeiws/Uh3Ube0P3sAwc=
Message-ID: <c9b0d7ba-4fbc-47ba-9343-faa1cad590c7@linux.microsoft.com>
Date:   Mon, 20 Nov 2023 12:03:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To:     Paul Moore <paul@paul-moore.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>,
        jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
 <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
Content-Language: en-US
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 11/16/23 14:07, Paul Moore wrote:
> On Tue, Nov 14, 2023 at 1:58 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 11/14/23 13:36, Sush Shringarputale wrote:
>>> On 11/13/2023 10:59 AM, Stefan Berger wrote:
>>>> On 10/19/23 14:49, Tushar Sugandhi wrote:
>>>>> =======================================================================
>>>>> | Introduction |
>>>>> =======================================================================
>>>>> This document provides a detailed overview of the proposed Kernel
>>>>> feature IMA log snapshotting.  It describes the motivation behind the
>>>>> proposal, the problem to be solved, a detailed solution design with
>>>>> examples, and describes the changes to be made in the clients/services
>>>>> which are part of remote-attestation system.  This is the 2nd version
>>>>> of the proposal.  The first version is present here[1].
>>>>>
>>>>> Table of Contents:
>>>>> ------------------
>>>>> A. Motivation and Background
>>>>> B. Goals and Non-Goals
>>>>>       B.1 Goals
>>>>>       B.2 Non-Goals
>>>>> C. Proposed Solution
>>>>>       C.1 Solution Summary
>>>>>       C.2 High-level Work-flow
>>>>> D. Detailed Design
>>>>>       D.1 Snapshot Aggregate Event
>>>>>       D.2 Snapshot Triggering Mechanism
>>>>>       D.3 Choosing A Persistent Storage Location For Snapshots
>>>>>       D.4 Remote-Attestation Client/Service-side Changes
>>>>>           D.4.a Client-side Changes
>>>>>           D.4.b Service-side Changes
>>>>> E. Example Walk-through
>>>>> F. Other Design Considerations
>>>>> G. References
>>>>>
>>>>
>>>> Userspace applications will have to know
>>>> a) where are the shard files?
>>> We describe the file storage location choices in section D.3, but user
>>> applications will have to query the well-known location described there.
>>>> b) how do I read the shard files while locking out the producer of the
>>>> shard files?
>>>>
>>>> IMO, this will require a well known config file and a locking method
>>>> (flock) so that user space applications can work together in this new
>>>> environment. The lock could be defined in the config file or just be
>>>> the config file itself.
>>> The flock is a good idea for co-ordination between UM clients. While
>>> the Kernel cannot enforce any access in this way, any UM process that
>>> is planning on triggering the snapshot mechanism should follow that
>>> protocol.  We will ensure we document that as the best-practices in
>>> the patch series.
>>
>> It's more than 'best practices'. You need a well-known config file with
>> well-known config options in it.
>>
>> All clients that were previously just trying to read new bytes from the
>> IMA log cannot do this anymore in the presence of a log shard producer
>> but have to also learn that a new log shard has been produced so they
>> need to figure out the new position in the log where to read from. So
>> maybe a counter in a config file should indicate to the log readers that
>> a new log has been produced -- otherwise they would have to monitor all
>> the log shard files or the log shard file's size.
> 
> If a counter is needed, I would suggest placing it somewhere other
> than the config file so that we can enforce limited write access to
> the config file.
> 
Agreed. The counter shouldn't be part of a config file.

IMA log already provides a trustworthy, tamper-resilient mechanism
to store such data.

The current design already provides the mechanism to store
the counter as part of the snapshot_aggregate event.

See section "D.1 Snapshot Aggregate Event" in the proposal for
reference.

Snapshot_Counter   := "Snapshot_Attempt_Count="
                               <num. snapshot attempts>


"snapshot_aggregate" becomes the first event recorded in the
in-memory IMA log, after the past entries are purged to
a shard file.  Along with the other benefits, the "snapshot_aggregate"
event also provides info to UM clients about how many snapshots are
taken so far.


See section "C.2 High-level Work-flow" in the proposal for more
info.

           Step #f
           ---------
      (In-memory IMA log)
    .----------------------.
    | "snapshot_aggregate" |
    | Event #E4            |
    | Event #E5            |
    '----------------------'

~Tushar
> Regardless, I imagine there are a few ways one could synchronize
> various userspace applications such that they see a consistent view of
> the decomposed log state, and the good news is that the approach
> described here is opt-in from a userspace perspective.  If the
> userspace does not fully support IMA log snapshotting then it never
> needs to trigger it and the system behaves as it does today; on the
> other hand, if the userspace has been updated it can make use of the
> new functionality to better manage the size of the IMA measurement
> log.
> 
