Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571952C1AF
	for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754742; cv=none; b=kd+r4uioGZeeUfpo3rXbixPpLQ7pGx37jbvT5uUVkUu+tVldfOzkmnztRQv7+6Cm7/rfWc89Rl9pd0dSe9xIjUn9uW8q309ndU1sCkgPYwXxCBdc4zjiq3TYRMk4cB3puCZylVYwwuGohkuueJS/wcLyOAiIW33XtfpUezGoaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754742; c=relaxed/simple;
	bh=5wo1sQKw2kJ1vRjCiJftFcLR0lel+0au/VGvTdZdmPY=;
	h=Date:From:To:Cc:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=PYhaITimkJ+c9G4+sBJbf9fs2vB8/Sl3ySS88+s1Y7WyE6zOZjpzoVKXPQahT3h82dkYX9mTM4szHJRw32+dc1yyR5jW3lupSJj351WJxGTdJB+CFDmtUZKMnVLGWXuW2HjZ/Najs+xaJcrK2MH4JKeLDoNdd7vhnZpzs4Cg1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42I9cQeJ030878;
	Mon, 18 Mar 2024 04:38:26 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42I9cPRd030877;
	Mon, 18 Mar 2024 04:38:25 -0500
Date: Mon, 18 Mar 2024 04:38:25 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: paul@paul-moore.com, roberto.sassu@huaweicloud.com
Cc: linux-security-module@vger.kernel.org
Subject: LSM/IMA integration denying access to inode_init_security.
Message-ID: <20240318093825.GA30817@wind.enjellic.com>
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
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 18 Mar 2024 04:38:27 -0500 (CDT)

Good morning Paul/Roberto, I hope this note finds your respective
weeks starting well, greetings to the wider security list as well.

We ran into an issue, that seems to be secondary to the LSM/IMA
integration, in our TSEM port to the 6.8 kernel that would seem to be
relevant to other or future LSM's.

It appears that the IMA/LSM work added the following code to the
security/security.c:security_inode_init_security() function:

if (!blob_sizes.lbs_xattr_count)
	return 0;

Which denies access to the hook by an LSM that has registered a
handler for an event but that has not registered the use of extended
attributes through the LSM blob mechanism.  This pre-supposes the
notion that all LSM's that may want to be notified of an inode
instantiation event will be using extended attributes.

For example, in TSEM we use this hook to propagate task identity
ownership and inode instance information from the
security_inode_create hook into the TSEM inode security state
information.

We 'fixed' the problem by requesting a single extended attribute
allocation for TSEM, but that seems inelegant in the larger picture,
given that a handler that wishes to use the hook in the absence of
extended attributes can use the hook and return EOPNOTSUPP with no ill
effects.

We haven't had time to track down the involved code but a cursory
examination would seem to suggest that this also effectively denies
the ability to create an operational BPF hook for this handler.  Given
that BPF is proposed as a mechanism to implement just any arbitrary
security policy, this would seem problematic, if it doesn't already
break current BPF LSM implementations that may have placed a handler
on this event.

We could certainly roll a patch for consideration on how to address
this issue if that would be of assistance.  At the very least the
documentation for the function no longer matches its operational
characteristics.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
