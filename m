Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA613C836
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147846; cv=none; b=THAYemmK0k47cflO1TBmxo0nWtyIxV9PTHA/nCxD597Qb4NOYHCvJpJom7U34tGChXZEmV53WoAfUMLQcIKJHGl7fyqXUCAr8srXD9k6SdByUJmumBCru/i9YDoZqE4Wi6gCvsyG21l6LlbIzijhpj7/qOH+VFmZH1QweUUnVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147846; c=relaxed/simple;
	bh=xfBKd1Ewon7HWbo7J2W+BGsGSpP0B3g6NS+w11psddo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4A1R3tyR5Lkg95VWf6KQtHVG7Zzckq+EB9r7kG/wAnPESNX08VCWSM3lKgzhVmhB8kt4siNTl5SBP5Nd038JWtw/X/hG5ckb8MM/NFnfojSEj5CG1qJU6T7RS3APStloauqiLK6a4kjfjBLfXkMOrcPraK43+yQ+Sc502eS1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 495H2bgY024279;
	Sat, 5 Oct 2024 12:02:37 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 495H2Z0c024278;
	Sat, 5 Oct 2024 12:02:35 -0500
Date: Sat, 5 Oct 2024 12:02:35 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        Fan Wu <wufan@linux.microsoft.com>, Micka??l Sala??n <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-security-module@vger.kernel.org
Subject: Re: TOMOYO's pull request for v6.12
Message-ID: <20241005170235.GA24016@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com> <202410041305.544EA7E4E@keescook> <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp> <202410041645.27A48DA@keescook> <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp> <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eaea237-d259-44bb-a546-26a0558a4453@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 05 Oct 2024 12:02:37 -0500 (CDT)

On Sat, Oct 05, 2024 at 09:10:08AM -0700, Casey Schaufler wrote:

Good morning to everyone, I hope the weekend is going well.

I saw this go by while I was multi-tasking between draining the oil
out of the lower unit on my boat motor and welding the boat lift
canopy frame and wanted to make sure that Tetsuo's comment is
interpreted in the correct context.

> On 10/5/2024 12:10 AM, Tetsuo Handa wrote:
> > ... It is possible that an attempt to make it
> > possible to use SELinux and Smack together is a wrong direction. Even if SELinux
> > and TSEM conflicts about their security models (and cannot be used together), it
> > might not be something we need to care...

> In the past I have said that having SELinux and Smack on the same
> system is the test case for module stacking, but that I didn't see
> it having a practical application. I have since been presented with
> a use case that seems reasonable. Because LSM is a mechanism for
> additional restrictions it is impossible for two security models to
> "conflict". LSMs *must* be written to allow for cases where access
> is denied for other reasons. You never get to the MAC check if the
> DAC check has already failed. If TSEM can't handle what SELinux or
> TOMOYO decides it shouldn't be accepted.

I believe that Tetsuo misinterpreted the discussions you and I have
had about what represents a 'security model'.

For the record, TSEM has no issue with handling whatever SeLinux,
SMACK, Tomoyo, AppArmor et.al. decide to do, full stop.

It functions like all of the rest of the LSM modules, it determines
whether or not a security event is inconsistent with the 'model' that
the process is running in, and if so denies it, otherwise it stands
aside and lets the other LSM's have a run at it.

If some other LSM in front of it decides to deny an event, well and
good, the event is over with from TSEM's perspective, as well as
anything else behind the denying LSM for that matter.

You raised the issue, I believe in V1, as to where we had positioned
TSEM in the LSM call list.  After you expressed concern we moved it to
the front of the call list because we don't care and everyone else
seems to want to be later in the stack, particularly at the end, which
would now seem to be be a privileged position held only by BPF.

To extend on this a bit for further clarification.

As we have evolved TSEM we realized that we actually want to be first,
if that isn't also a coveted position.

For example, internally, we have TSEM 'models' whose only function is
to validate that the extended security attributes of an inode match
what the workload was unit tested to, in order to thwart offline
modification attacks.  In this case you want TSEM to be running ahead
of the security attribute based models, since presumably, you would
not want those models making a decision on extended attributes that
have been modified.

Hopefully this clarifies the issue.

We have a long standing question, that has never been answered,
regarding module stacking and multiple MAC implementations on the same
OS instance but we will leave that to another conversation.

Now back to MIG welder.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
