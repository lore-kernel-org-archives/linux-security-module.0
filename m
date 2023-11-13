Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BEC4332F
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Nov 2023 18:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKMSOj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Nov 2023 13:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjKMSOi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Nov 2023 13:14:38 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A5ED53;
        Mon, 13 Nov 2023 10:14:35 -0800 (PST)
Received: from [10.137.114.52] (unknown [131.107.159.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id C5F7F20B74C1;
        Mon, 13 Nov 2023 10:14:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5F7F20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699899275;
        bh=PQZ5UmPmG9pef+E8G3YPru2uMvofveJcbTaptSpXym8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=If6jd5xAyRgPs1mkzjtt0JuLiVptdwy3eAWFRmV0jEc6GBjz9CKpOBgCdemAX9/OQ
         BUcs3cRJYY9NUnjcxmMd8YbDg5IN0bJQnobcdzFp2exSnOMR7/PVaz3vPz+nbFH/z+
         16Yr5nQc2vWnH3kaKyVCXQd87neogo/GzKDQeza8=
Message-ID: <86366328-512e-47a0-950d-450412319c26@linux.microsoft.com>
Date:   Mon, 13 Nov 2023 10:14:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To:     Ken Goldman <kgold@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>,
        jgg@ziepe.ca, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Content-Language: en-US
From:   Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 10/31/2023 11:37 AM, Ken Goldman wrote:
> On 10/19/2023 2:49 PM, Tushar Sugandhi wrote:
>>    f. A new event, "snapshot_aggregate", will be computed and measured
>>         in the IMA log as part of this feature.  It should help the
>>         remote-attestation client/service to benefit from the IMA log
>>         snapshot feature.
>>         The "snapshot_aggregate" event is described in more details in
>>         section "D.1 Snapshot Aggregate Event" below.
>
> What is the use case for the snapshot aggregate?  My thinking is:
>
> 1. The platform must retain the entire measurement list.  Early 
> measurements can never be discarded because a new quote verifier
> must receive the entire log starting at the first measurement.
>
> In this case, isn't the snapshot aggregate redundant?
Not quite. The snapshot aggregate still has a purpose, which is to stitch
together the snapshots on the disk and the in-memory segment of the IMA
log. The specific details are in the RFC Section D.1, quoted here:

The "snapshot_aggregate" marker provides the following benefits:

a. It facilitates the IMA log to be divided into multiple chunks and
provides mechanism to verify the integrity of the system using only the
latest chunks during remote attestation.

b. It provides tangible evidence from Kernel to the attestation client
that IMA log snapshotting has been enabled and at least one snapshot
exists on the system.

c. It helps both the Kernel and UM attestation client define clear
boundaries between multiple snapshots.

d. In the event of multiple snapshots, the last measured
"snapshot_aggregate" marker, which is present in the current segment of
the IMA log, has sufficient information to verify the integrity of the
IMA log segment as well as the previous snapshots using the PCR quotes.

e. In the event of multiple snapshots, say N, if the remote-attestation
service has already processed the last N-1 snapshots, it can efficiently
parse through them by just processing "snapshot_aggregate" events to
compute the PCR quotes needed to verify the events in the last snapshot.
This should drastically improve the IMA log processing efficiency of
the service.

>
> 2. There is a disadvantage to redundant data.  The verifier must 
> support this new event type. It receives this event and must validate 
> the aggregate against the snapshot-ed events. This is an attack 
> surface. The attacker can send an aggregate and snapshot-ed 
> measurements that do not match to exploit a flaw in the verifier.
I disagree with this.  Redundancy is a moot point because
"snapshot_aggregate" is required for the points mentioned above.
- Sush
