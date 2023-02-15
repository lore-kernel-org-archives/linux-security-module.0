Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35856C636D4
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Feb 2023 16:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjBOQ1f (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Feb 2023 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBOQ1e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Feb 2023 11:27:34 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B42AA36FFE
        for <linux-security-module@vger.kernel.org>; Wed, 15 Feb 2023 08:27:33 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31FGQr8i009012;
        Wed, 15 Feb 2023 10:26:53 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31FGQqiC009009;
        Wed, 15 Feb 2023 10:26:52 -0600
Date:   Wed, 15 Feb 2023 10:26:52 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
Message-ID: <20230215162652.GA8693@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com> <CAHC9VhQnZhczVRifSnM-zv46Cb9OFuh=6ha+1zKJaOUK15=K5A@mail.gmail.com> <20230214115822.GA28408@wind.enjellic.com> <39e59a09730514a88449b8fb41e23598a4bc03d6.camel@huaweicloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39e59a09730514a88449b8fb41e23598a4bc03d6.camel@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 15 Feb 2023 10:26:53 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 14, 2023 at 01:18:45PM +0100, Roberto Sassu wrote:
> On Tue, 2023-02-14 at 05:58 -0600, Dr. Greg wrote:
> > Our personal prejudice is that these types of measurements are of
> > limited value, which is why we introduce in TSEM, the notion of the
> > 'state' value for a model, discussed below.
> > 
> > I would have to go looking on lore for a reference to the exact thread
> > but Roberto Sassu had offered up a patch set for IMA that addressed
> > the deficiency of these types of measurements.

> Hi Greg

Good morning Roberto, thank you for taking the time to follow up,
pleasant to hear from you.

> yes, this:
> 
> https://lore.kernel.org/linux-integrity/20210914163401.864635-1-roberto.sassu@huawei.com/
> 
> DIGLIM makes the PCR extended with software measurements deterministic,
> independent from how processes are scheduled, at the cost of not
> knowing if files with matching digests from a list were accessed or
> not, and in which order.

Yes, DIGLIM, I remember the patch series you sent out but couldn't put
a name to it when I wrote the reply to Paul.

Our efforts and work share the same issues with respect to the
indeterminism of strictly linear extension measurements, particularly
now in the age of ubiquitous SMP.

The 'state' value supported by the Quixote model is designed to
address the same problem and has worked extremely well for us.  Our
implementation only sorts the security state event points that have
been 'touched' by the execution trajectory, so it does provide a
measurement of the events that have occurred.

Like DIGLIM, you lose the the ordering of the events, but we also
provide the linear sequence of security state points, and its classic
measurement value, if one wants to go down the rabbit hole of figuring
out if the integrity of the system has been affected by process
scheduling.

Frankly, I don't see the current state of the art in trusted systems
being in a position to worry about that at this point in time.

> But, in exchange, you can seal a TLS key to IMA measurements that is
> available for handshakes as long as the system does not execute
> something unknown. After that, you have to reboot to use the key
> again.

The same rationale for why we developed the notion of the model
'state' value.

We also look at the 'state' value as a method for a containerized
workload, coming out of a CI/CD development framework, to provide an
attestation of a single value to indicate whether or not the workload
is correct or trusted.

We believe this will become increasingly important as technologies
like TDX, and AMD's equivalent come forward, that will be requiring
attestation as a function of the 'boot' sequence.

> (Didn't read your proposal yet.)

Once you get a chance to look at Quixote/TSEM and things settle down
for us a a bit, we should chat about a common kernel framework for
cacheing digest values as our needs are quite similar.  There would
seem to be no compelling reason to build separate implementations of
the same technology.

Our current digest cache was only driven by the mandates of simplicity
and correctness.  Our plans are to add the equivalent of a Bloom
filter in front of a bucket of lists that key on the MSB of the digest
value.  If I remember correctly, you had expended efforts on
optimizing your implementation.

One ends up with a lot of security event state points when you boot a
modern general purpose Linux administration.

> Roberto

Thanks again, will look forward to chatting about these issues
further.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
