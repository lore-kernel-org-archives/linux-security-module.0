Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A83C0015E
	for <linux-security-module@archiver.kernel.org>; Tue,  1 Aug 2023 10:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHAKnE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 1 Aug 2023 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjHAKm7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Aug 2023 06:42:59 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFD42B1
        for <linux-security-module@vger.kernel.org>; Tue,  1 Aug 2023 03:42:57 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 371AgQTw022920;
        Tue, 1 Aug 2023 05:42:26 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 371AgPPL022919;
        Tue, 1 Aug 2023 05:42:25 -0500
Date:   Tue, 1 Aug 2023 05:42:25 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/13] Implement Trusted Security Event Modeling.
Message-ID: <20230801104225.GA22902@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com> <CAEjxPJ7a8AhO3VztWc3pP47v0ky3sM-HjUJVq4ocguVd5UAWKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjxPJ7a8AhO3VztWc3pP47v0ky3sM-HjUJVq4ocguVd5UAWKw@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 01 Aug 2023 05:42:26 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 31, 2023 at 10:38:42AM -0400, Stephen Smalley wrote:

Good morning Stephen, I hope this note finds your day starting well.

It has been awhile since we have spoken, the Linux Security Summit in
2015 if I remember correctly.

> I have no stake in this, but just wondering whether you considered
> using the BPF LSM to implement your logic via eBPF programs. The BPF
> LSM allows one to attach eBPF programs to any/all LSM hooks. That
> would allow your security model to be used on any kernel >= 5.7. If
> I were writing a LSM from scratch today, that's what I would do...

An interesting and relevant observation.

We have some initial eBPF work completed, but that work suggests that
TSEM is a vehicle for implementation of eBPF functionality, rather
than a candidate for replacement by eBPF.  It is unclear, at least
from our pespective, perhaps we are misinformed as to eBPF capability,
as to how eBPF would replace TSEM functionality.

A rather fundamental premise of TSEM, and a large part of its
implementation, is the notion of security modeling namespaces.  We've
probably spent as much time as anyone on working with the mathematical
modeling of security behavior and it seems unlikely that relevant
models can be developed without isolating the model to the
characteristics of a specific workload.

The ability to externally model the security behavior of a workload is
also important with respect to the use of trust roots such as SGX
enclaves, other TEE's and hardware trust implementations.  For
example, with SGX an implementation has to be done in userspace, I
also wouldn't envision machine learning implementations as being
acceptable for inclusion in the kernel proper.

The value that we see with eBPF, in respect to TSEM, is as a means of
implementing Quasi-Deterministic Models (QDM's) with an in-kernel
Trusted Modeling Agent (TMA) implementation.  In QDM's, eBPF programs
would be used to implement 'parameter leveling' prior to the
generation of the security state coefficients.  This provides a path
for a single kernel modeling implementation to support multiple model
definitions.

An in-kernel TMA is a significant consumer of the kernel cryptographic
functionality, both for the generation of security state coefficients
and the cryptographic checksumming of files and executable code.

With respect to these issues, would IMA be considered as a candidate
for replacement with eBPF functionality?  We would be extremely
interested in community sentiment on this issue.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
