Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093097;
	b=QTi+4j01dqKFLtadqnSTh4sMgUzeUM9g0EuTm+iDDvxYD0cN/hBZR43VZC7OAMqVHRvM
	 mLeWLSCwmVujp4PY4QvG78eJ771Bs6kKMtpsuYRRSVmunc54fVRuNB0aB+11SoMNk2bOv
	 dlEmmxUkH5xVTIel7B7BsemtmeUt08CvWK17lkPtA2ufOdyXc/AS+O8AAs/TlNas3Pn0u
	 RNhQGLYxr67GUJQLdGF5fqwIwguh8PeoUT5ujbM+WKiBVqnrfDW1bmx0nDHKt/SGHLlRE
	 EOk0v8geRyFz6gfJ2xU3jawz3bB5NIDH86MRxvTbLBKKSCpm5KhmlOW+fdu5yMzW9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=jVmoiMOYtuI9ktRo1elrluNIumXG5xfU1JF0RrrL6LA=;
	b=hDVxuDSGz+Bdqa6hMW8Jbm6fJg9P8RC4Rlf8Qm48pwt9cI/YlLF5+aOkwyoP8gWzXVk6
	 0GQryS+SCcjI4jlWnxKEmTiEL7/GrzZasorTXiJZtNB4IO9PaOt4ZYEtZupshTxKnucys
	 kew2RvUa+1d9+jD+e8gsi5/0iCItO8ox0NjZAWoHP1SENy4A5ynHcJVzSuagEWT/nfLug
	 d6xry8rAc75T2nFufFEVMclBfNa3Ui9aM/Oizc9yRGDMCxGmt8sI3LxbLKw67rtPOdSN2
	 NIOi7Wj3PiF7EsXEICDRTf3UuUenqJ3E9V3B9uZ+2nIpuXNKvdewYVKLGEp2icjKWFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZoU+cvv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F0606A31D;
	Tue, 27 Oct 2026 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZoU+cvv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A271F01825;
	Tue, 27 Oct 2026 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093097;
	bh=jVmoiMOYtuI9ktRo1elrluNIumXG5xfU1JF0RrrL6LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kZoU+cvvg+Uaxt93WSvNa39ekC/nms9Dh3D6qeSoLDOvmquKzCzkQi0CgBe1v2nWL
	 5GD+Rb35FYjNMAD4RHbnqheUJ/tzr+bf3FW1OgW191FshAlozCsk2UZljjWo1gdKsl
	 cAZhTYeVhsid7Uf/F5pFYqYlemM/IjJ2jbuZynePh4AFeqJCpWG4gZmizxVyPUpjqz
	 qoBtP8hH/kDlIBY1SPPmhVFs7HkxO+Teg4GNIdLYi1jEwYkdg6O3gg3VsZtB5I6aem
	 0hIQ8Ghi75+hiG6CVVgVJQwDaEfyCGIXY0WcoMBmlKXQxwe4fkSh31fLVxoPFFyZn2
	 ovNfkW9oEvH5A==
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	netdev@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
Date: Tue, 27 Oct 2026 10:24:28 +0100
Message-ID: <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org> <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717; i=brauner@kernel.org; h=from:subject:message-id; bh=a0tQj4zM6yRVUYT5loClZPWWa4Kil1MrBWSlYtSs7uE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9yL21Lirg4n7HnDqL3r2nWabsbIwt37H6e+pdlge1G Refhh+80FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRroOMDAfmsrsIqdlufX3l 5eG9OWfyIqJ7tBoC/z7+vbr3XLt+2jNGhiOZKmWb/bon622Ne6Cksc158o6szgbZNM2Jmzu3r+P y5QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, Oct 26, 2026 at 04:31:25PM -0400, Paul Moore wrote:
> From what I'm reading the LSM framework patches don't meet the typical
> LSM criteria for stable/RC fixes: there is no serious bug/panic, and
> there is no functional regression from a previous release.
> This looks like one of those unfortunate circumstances where a new use
> case wasn't tested thoroughly enough before the merge window, so it
> can wait for the next one.

My original patchset had a selftest that excercised the BPF LSM usability
extensively. The hooks are new this cycle and broken for the main use-case I
wrote the patchset for.

If we don't fix them now they need to be backported next cycle which I'm sure
the stable developers will enjoy.

Curiously, your pull request told Linus "I expect that BPF LSM developers will
also be making use of the namespace hooks, if they haven't already". So it
seems very strange to claim this as a new use-case.

>From my perspective the timeline looks like this - I'm sure yours differs:

  I wrote an implementation for the BPF LSM to use a set of new hooks in a
  subsystem I maintain months ago.

  You rejected the hooks because BPF LSM programs cannot serve as justification
  to introduce new hooks. Only in-tree LSM (selinux, apparmor, landlock, etc) can.

  I cannot fulfill this requirement because I neither have the expertise nor
  the use-case for any in-tree LSMs.

  Landlock wants to make use of this by pure chance. So the maintainer offers
  to take over the patchset. He does.

End result after more than two kernel releases: The patchset that ends up
merged into upstream doesn't work with the original motivating use-case because
all the BPF LSM bits got dropped. So far, no problem. That may happen as long
as we can the fix it rapidly.

Then I take the time to send this series of fixes to actually restore the
original use-case so we don't release a kernel with a new api that doesn't work
for the main use-case I developed this for.

Once again, I get told no. This time because the functionality isn't broken the
right way to justify a merge-window follow-up. Instead, we'll release
half-working functionality.

I'm really on the fringes of this endless debacle but this seems to be another
iteration of "BPF people don't get along with LSM people" therefore they make
each other's lifes and that of innocent bystanders that just want to get work
done difficult.

I really don't understand why it's preferable to release a kernel where the
original use-case that I was forced to explicitly abandon doesn't work and
there's no reliable or cost-efficient way for userspace to detect whether the
hook works correctly.
