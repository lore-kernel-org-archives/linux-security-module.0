Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF2C636D4
	for <linux-security-module@archiver.kernel.org>; Sat, 11 Feb 2023 00:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBKAdP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Feb 2023 19:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKAdP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Feb 2023 19:33:15 -0500
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E80C1ADC5
        for <linux-security-module@vger.kernel.org>; Fri, 10 Feb 2023 16:33:14 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 31B0Wq8D032551;
        Fri, 10 Feb 2023 18:32:52 -0600
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 31B0WpfE032550;
        Fri, 10 Feb 2023 18:32:51 -0600
Date:   Fri, 10 Feb 2023 18:32:51 -0600
From:   "Dr. Greg" <greg@enjellic.com>
To:     "Serge Hallyn (shallyn)" <shallyn@cisco.com>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 04/14] Implement CAP_TRUST capability.
Message-ID: <20230211003251.GA32521@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-5-greg@enjellic.com> <Y+E4pe8T7Z1ekJqo@jerom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+E4pe8T7Z1ekJqo@jerom>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 10 Feb 2023 18:32:52 -0600 (CST)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 06, 2023 at 05:28:06PM +0000, Serge Hallyn (shallyn) wrote:
> On Fri, Feb 03, 2023 at 11:09:44PM -0600, Dr. Greg wrote:
> > TSEM was designed to support a Trust Orchestration System (TOS)
> > security architecture.  A TOS based system uses the concept of a
> > minimum Trusted Computing Base of utilities, referred to as trust
> > orchestrators, that maintain workloads in a trusted execution
> > state.  The trust orchestrators are thus, from a security
> > perspective, the most privileged assets on the platform.
> > 
> > Introduce the CAP_TRUST capability that is defined as a
> > capability that allows a process to alter the trust status of the

> This sounds like CAP_MAC_ADMIN.  Any reason not to re-use that?

Hi Serge, thanks for passing along the question.

Casey raised the same issue, will respond in more detail in a reply to
his e-mail.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
