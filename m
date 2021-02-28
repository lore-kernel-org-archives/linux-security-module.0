Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B781C433E6
	for <linux-security-module@archiver.kernel.org>; Sun, 28 Feb 2021 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2956A64DD3
	for <linux-security-module@archiver.kernel.org>; Sun, 28 Feb 2021 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhB1S6d (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:58:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:56460 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhB1S6c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 28 Feb 2021 13:58:32 -0500
IronPort-SDR: MfbyOPu0Yx+WHZxJ4WLyRmdzYnfL6K7KwEyugnR/mBM71IAw1+8FcUcZKvjWmFt2up4BPNMavj
 XluFkyBADXbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="250344198"
X-IronPort-AV: E=Sophos;i="5.81,213,1610438400"; 
   d="scan'208";a="250344198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 10:56:45 -0800
IronPort-SDR: xO1quA5tSkLr7Wa+aYfB/kLKW49fcvhM94c931ze3tJs/vunXvX5r099AOLt2c3f4sxun4b6LN
 d6gKQrkop9Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,213,1610438400"; 
   d="scan'208";a="368370565"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2021 10:56:45 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7FB5E3015E2; Sun, 28 Feb 2021 10:56:45 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
References: <20210227153013.6747-1-john.wood@gmx.com>
        <20210227153013.6747-8-john.wood@gmx.com>
Date:   Sun, 28 Feb 2021 10:56:45 -0800
In-Reply-To: <20210227153013.6747-8-john.wood@gmx.com> (John Wood's message of
        "Sat, 27 Feb 2021 16:30:12 +0100")
Message-ID: <878s78dnrm.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

John Wood <john.wood@gmx.com> writes:
> +
> +To detect a brute force attack it is necessary that the statistics shared by all
> +the fork hierarchy processes be updated in every fatal crash and the most
> +important data to update is the application crash period.

So I haven't really followed the discussion and also not completely read
the patches (so apologies if that was already explained or is documented
somewhere else).

But what I'm missing here is some indication how much
memory these statistics can use up and how are they limited.

How much is the worst case extra memory consumption?

If there is no limit how is DoS prevented?

If there is a limit, there likely needs to be a way to throw out
information, and so the attack would just shift to forcing the kernel
to throw out this information before retrying.

e.g. if the data is hold for the parent shell: restart the parent
shell all the time.
e.g. if the data is hold for the sshd daemon used to log in:
Somehow cause sshd to respawn to discard the statistics.

Do I miss something here? How is that mitigated?

Instead of discussing all the low level tedious details of the
statistics it would be better to focus on these "high level"
problems here.

-Andi

