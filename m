Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA432D443
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783941; cv=none; b=VFAuUeU0Na7nAGbB2Z99MnckFLnNuJww4cvbHox7qd1xtTmBkgffSmoBlbgscCj/HBh1jUfAzGa6RgrevR8cq0iI+ExI0BvOPYExnjWXIgDUzRNYSUMOu+9nMcMgwy3NFRfSh/LCyh2HrN6QwTpXDJ33kzQonEyIhIzL1rq27e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783941; c=relaxed/simple;
	bh=2E9AG996dlA53KPGlr+xaUiBHTXkBzBWZ0Oc4bKsLAE=;
	h=Date:From:To:Cc:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=KS/SEROXN8apQ5uJVbvpoAif4ImoxeL4REw83IiWSGg6T1WiOXwo+iAhdir9UR6jQAwfyb9Lztt6Kv8OYWfc44ssfX5NmPUU+/wsrqOQ4EPDDqsk1YIGoCMUozxpIj2jDXiIXIMW5N8PCFSl1J8kAGHEeXPtjWSct/cUyOHqeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 5BF78iO0007252;
	Mon, 15 Dec 2025 01:08:44 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 5BF78cU9007251;
	Mon, 15 Dec 2025 01:08:38 -0600
Date: Mon, 15 Dec 2025 01:08:38 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: linux-security-module@vger.kernel.org
Cc: torvalds@linux-foundation.org, corbet@lwn.net
Subject: A formal request for process clarifications.
Message-ID: <20251215070838.GA7209@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 15 Dec 2025 01:08:44 -0600 (CST)

Good morning, I hope the week has started well for everyone.

When Paul Moore took over as the security/LSM sub-system maintainer,
three years ago, he indicated a desire to be very prescriptive with
respect to the practices that should be followed for the sub-system,
particularly for the introduction of new LSM's.

The following URL documents the requirements for the introduction of a
new LSM:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsms

We believe that LWN covered the discussion around this document as well.

The following discussion on whether or not the Linux kernel provides
proper support for modern Event Detection and Response Systems (EDR or
EDRS) suggests the need to clarify these recommendations:

https://lore.kernel.org/linux-security-module/CABZOZnS4im-wNK4jtGKvp3YT9hPobA503rgiptutOF8rZEwt_w@mail.gmail.com

In that thread Timur Chernykh noted a possible desire to port the
Apple security API to the kernel, which would presumably be a large
body of virgin code.

Three years ago our team had submitted for review our TSEM LSM that
provides a framework for generic security modeling, particularly to
support machine learning and direct functional modeling of security
behavior.

We haven't been able to receive any substantive review of TSEM over
that period of time.

Casey Schaufler has been vocal in his criticism of how we introduced
what is a virgin LSM implementation.  Most particularly with the fact
that we chose to include, as a single patch, a header file that
contains the structure and enumeration definitions that are referenced
by all of the compilation units that make up TSEM.

He indicates that an LSM submission, should 'tell a story' by bringing
in the structure definitions with the code that uses those structures.

We can offer multiple examples of the challenges we see with doing
this if that would be helpful but will not do so at this time.

We had requested guidance from Paul on how a new submission should be
properly structured, since he is the ultimate judge and jury on a
submission, but he declined to provide guidance.

Given the current security climate, particularly with what is widely
cited as the potential impact of machine learning and AI on security
architectures and practices, there will undoubtedly be new LSM's
coming forward.  It would seem in the best interests of everyone
involved, reviewers and submitters, that specific guidance should be
codified in the 'new-lsms' document of how a virgin body of code
should be introduced.

Optimally this should include links to previous submissions that the
security maintainers believe codify the desired method of story
telling.

Given the importance of security in today's environment we are
prepared to pursue this through the TAB if necessary.

We will look forward to comments from the community on this issue.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
