Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413E4A2F
	for <linux-security-module@vger.kernel.org>; Thu, 21 Mar 2024 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063956; cv=none; b=oVdtAUCLxjmFFPfgcu6NdySXACPqYXBdfF/LG9nlii9uEOQOdJGcdPGMdEp3AVGwr4ws26DkQuiqakKZulzCbKdRrvbyUVT6opVWqHGioDY9LOmVTZw5XIFaS5hmaJKafm7k+3vez8X5s5F2PYyccslHofT447hlJUYZFtlLM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063956; c=relaxed/simple;
	bh=/wLVzCvQXT2aAbNZ7UTZiDXqk9Cvi0SPA+rQtM989oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lusuA1utT9H8gcgY16OJ68i9Lwe3cJoBlRyNrLdsPCh59lPRR87wlbqOaK6jlwA68ozjkGdw4t8IZqnNl3+dqKzOsinBS17Gfz/xJzKBCepOp5UdqzAjUnVCGffnlZOsBStZwFoRk5vSRObyV20FvPWNMrjsD97Ujsrvf3KPC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42LNVtIs000895;
	Thu, 21 Mar 2024 18:31:55 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42LNVsZ5000893;
	Thu, 21 Mar 2024 18:31:54 -0500
Date: Thu, 21 Mar 2024 18:31:54 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org
Subject: Re: LSM/IMA integration denying access to inode_init_security.
Message-ID: <20240321233154.GA848@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240318093825.GA30817@wind.enjellic.com> <3ae1387eda0da59199e3e7f736d8dd30281b6b9d.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae1387eda0da59199e3e7f736d8dd30281b6b9d.camel@huaweicloud.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 21 Mar 2024 18:31:55 -0500 (CDT)

On Mon, Mar 18, 2024 at 11:39:38AM +0100, Roberto Sassu wrote:
> On Mon, 2024-03-18 at 04:38 -0500, Dr. Greg wrote:
> > Good morning Paul/Roberto, I hope this note finds your respective
> > weeks starting well, greetings to the wider security list as well.
> > 
> > We ran into an issue, that seems to be secondary to the LSM/IMA
> > integration, in our TSEM port to the 6.8 kernel that would seem to be
> > relevant to other or future LSM's.
> > 
> > It appears that the IMA/LSM work added the following code to the
> > security/security.c:security_inode_init_security() function:
> > 
> > if (!blob_sizes.lbs_xattr_count)
> > 	return 0;
> > 
> > Which denies access to the hook by an LSM that has registered a
> > handler for an event but that has not registered the use of extended
> > attributes through the LSM blob mechanism.  This pre-supposes the
> > notion that all LSM's that may want to be notified of an inode
> > instantiation event will be using extended attributes.
> > 
> > For example, in TSEM we use this hook to propagate task identity
> > ownership and inode instance information from the
> > security_inode_create hook into the TSEM inode security state
> > information.
> > 
> > We 'fixed' the problem by requesting a single extended attribute
> > allocation for TSEM, but that seems inelegant in the larger picture,
> > given that a handler that wishes to use the hook in the absence of
> > extended attributes can use the hook and return EOPNOTSUPP with no ill
> > effects.

> Hi Greg
> 
> I agree, it should not be needed.

Thanks Roberto, I'm glad you tentatively read the situation as we did.

> > We haven't had time to track down the involved code but a cursory
> > examination would seem to suggest that this also effectively denies
> > the ability to create an operational BPF hook for this handler.  Given
> > that BPF is proposed as a mechanism to implement just any arbitrary
> > security policy, this would seem problematic, if it doesn't already
> > break current BPF LSM implementations that may have placed a handler
> > on this event.
> > 
> > We could certainly roll a patch for consideration on how to address
> > this issue if that would be of assistance.  At the very least the
> > documentation for the function no longer matches its operational
> > characteristics.
> 
> I think the check above was just an optimization, but I agree you might
> do other tasks, other than just filling the xattrs slot.
> 
> For me, it would not be really a problem to modify the code to invoke
> the inode_init_security hooks with xattrs set to NULL.
> 
> I haven't found any counterargument, but will think some more.

Paul, do you have any reflections on this?

If not, we will propose a patch to return the previous behavior.

> > Have a good week.
> 
> You too!
> 
> Roberto

Thanks for the comments, have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
