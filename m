Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F05AD24
	for <linux-security-module@vger.kernel.org>; Thu,  8 Jan 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888698; cv=none; b=h78k4f/2Zm/FWhYIPB0Usob9tanGF4WnJCZkrbZFxIutWfiub70GJaTTtMgKAdjrWvBCYeLqb1AOy5me8itSdSTXzru2cTwu2wLByfslgTseFMMZ3p350dUlcse0h7ciYeuRk0qhLok8+8XGsi1g4SJ8w5Oh6b960z3nczezNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888698; c=relaxed/simple;
	bh=a2risomvSkbclWqO/xOIGA1Xq4rJTPZMP/KquX50Ox0=;
	h=Date:From:To:Cc:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=BNgy7l4B5uefDUH8rcDevKMf9PTD61eHX8ii6g5x+fJC2FsCcRR1vOz9cfz1+fiAdJcGw1NMCPe8jO4oI2ZqmWyIwHF9hQrzSNMEAxj2ii+auChfNX+0dujQiC7FC25qnOfFpN8va8KmiTlXCVBxsuYeKPEwnbi+w/p9q1VRMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 608FkCgM014369;
	Thu, 8 Jan 2026 09:46:12 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 608Fk5Ze014361;
	Thu, 8 Jan 2026 09:46:05 -0600
Date: Thu, 8 Jan 2026 09:46:05 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org
Subject: Improved guidance for LSM submissions.
Message-ID: <20260108154604.GA14181@wind.enjellic.com>
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
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 08 Jan 2026 09:46:12 -0600 (CST)

Good morning Paul, I hope this note finds your week going well and you
were able to have enjoyed a pleasant holiday season.

The Linux security community has benefited from your prescriptive
guidelines for the sub-system that you developed when you took over
the maintainership role.

What is not clear in these guidelines is how a virgin LSM should be
structured for initial submission.  Moving forward, we believe the
community would benefit from having clear guidance on this issue.

It would be helpful if the guidance covers a submission of 10-15 KLOC
of code and 5-8 compilation units, which seems to cover the average
range of sizes for LSM's that have significant coverage of the event
handlers/hooks.

We will look forward to your reflections and guidance on this issue.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
