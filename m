Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C401E883E;
	Fri, 31 Jan 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343536; cv=none; b=rdd/6srhEK4ZohfCzXq9lqAc/xwBaDxh0A4EujkPWx6DRola8ARpSbgn5zfdeLynIWDFDq704sdOs7jEnQHvJZapGRJP1CNJUIVaFRziwfDsjc89ybCS9R/zGuLYvsUyuOSDV1GqlM3AlO9kDbiUHVgjbJe+pTeoKMZPHBc70Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343536; c=relaxed/simple;
	bh=/LCq12bptwXvbV+DpJIj08mZpqWu62i3B3vmHOcuEIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBf7LxLQs7jI2rdwV580VFBH0pogsOJYCVy/V0rH6qbngOuRZwm8mm/KEZb8PjTQaAJgyszOCQdiOHR2k3QQsteXdj3iqyDMHmfToUvuynUq5tKcwvDIwh/AGEORGT0p2C9w9ZJEB07JlwOfUDTc10qjOIx7OwvSOD4AHNbpvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 50VHBdRr010206;
	Fri, 31 Jan 2025 11:11:39 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 50VHBbx5010203;
	Fri, 31 Jan 2025 11:11:37 -0600
Date: Fri, 31 Jan 2025 11:11:37 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250131171136.GA10065@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250117044731.GA31221@wind.enjellic.com> <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 31 Jan 2025 11:11:39 -0600 (CST)

On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:

Good morning, I hope the week is going well for everyone.

We will deal with the issues you raised in separate e-mails,
particularly the one below, since we have been advised that no one
likes to read very much.

> > > Presumably an attacker could craft a malicious executable (or
> > > influence the CELL value if it incorporates user controlled values)
> > > that collides with the digest of a known and trusted application.
> >
> > An incredibly important issue, so apologies for a more lengthy reply
> > on this issue.
> >
> > More precisely, the objective for an adversary would be to generate
> > the same security coefficient for a specific security event type using
> > an alternative ensemble of operating system relevant characteristics
> > for the event.
> >
> > The generative functions for the COE, CELL, task identities and
> > ultimately the security state coefficients, are based on industry
> > standard cryptographic hash functions.  The attack scenario suggested
> > above would represent a major failure in the second pre-image
> > resistance characteristics of these industry standard security
> > primitives.
> >
> > The ability to decept these security primitives, in such a manner,
> > would represent a crisis for the entire technology industry.

> Look around, it is happening now.

No it isn't, at least not for primitives that are currently security
relevant, here is why we know it isn't happening.

For simplicity, let's take SHA256, the hash function that TSEM uses by
default.

SHA256 is one member of the family of hash functions that is currently
codified for use in the Federal Information Processing Standards
(FIPS) document 180-4.  FIPS specifically validates this hash function
on the basis of its demonstrated first and second pre-image resistance
strength for non-classified and non-military security applications.

FIPS compliance is a requirement for federal contracting and
compliance, particularly for anything to do with money; banks, credit
cards (PCI) etc., security issues that people take very, very
seriously.

If an active exploit in a FIPS validated primitive was understood to
exist, the US Commerce Department would be required to publish a
revision to the acceptability clause of 180-4.  Since the National
Institute of Standards holds the responsibility for the performance of
federally mandated algorithms, they would in turn, be required to
issue a deprecation notice along with a mitigation and transition
strategy.

The Federal Register currently does not document the publication of
any such notices.

If you doubt that this isn't a well understood process and one that is
taken very seriously, review the December 13, 2024 deprecation and
transition announcement for RSA-2048 and ECDSA-256.

All that being said, we could have missed something, if what you
propose is currently happening, please cite the CVE number that
documents an operational exploit of the second pre-image resistance
strength of this hash function or a reference to the Federal Register
publication of one of these notices.

FWIW, one of our team members did the first FIPS compliance and
validation work for a technology company that is a major employer of
Linux kernel developers.

> Of course the level of risk varies tremendously based on the
> application and yes, the chosen hash function.  However, given the
> composition of TSEM's CELL value in some events, and the importance
> of a hashed event value in TSEM's policy/model enforcement, it seems
> like this is something that one would want to address.

We do address it, two primary points:

One, by default, TSEM uses SHA256 and it is currently accepted that it
would be computationally infeasible for an attacker to find a second
pre-image for a security coefficient generated with this function.

Two, TSEM supports algorithmic agility, so if a functional second
pre-image attack emerged, there is an expectation that there would be
a migration to a non-vulnerable primitive.  This is considered
standard and acceptable practice in the security industry.

An even deeper and more fundamental reason why this type of attack
wouldn't be relevant in a TSEM protected workload.

The independent variables in the TSEM generative model are the
security events being modeled.  OS level actions that would express
the efforts of an adversary consist of multiple security events, each
with their own security state coefficient that would have be mapped
into a known good coefficient by manipulation of the characteristics
of each independent variable.

Lets look at the Apache Struts vulnerability that was the basis for
the Equifax breach [1], arguably the start of the modern day era of
major persistent exploits.

The vulnerability in the attack was taking advantage of a
serialization regression in the Apache Struts code.  This regression
was used to implant a .war file that was executed by the Tomcat
application server, that in turn fetched a webshell that was used to
access the host and establish persistence.

There are two sentinel events in the compromise:

	1.) Implantation of the .war file.
	2.) The use of wget to enable access and persistence.

In event 1 there will be a series of security states that are
occupied, if you will pardon my background in quantum, that represent
the events necessary to write the .war file.  The only degree of
freedom that the attacker can control is what would be the
cryptographic hash of the contents of the .war file.  Manipulation of
that file would have to yield a file (pre-image) that would still be
interpreted as a valid .war file.

The attacker must do so without any knowledge of the Tomcat execution
environment and the known good states that it will occupy.  In a
classic compromise an attacker only needs to know they are attacking a
Tomcat/Struts execution environment.

With respect to the second sentinel event, the execution of the wget
binary for installation of the persistence infrastructure.  In a TSEM
model of the compromise on a 6.12 kernel, the wget invocation is
modeled by a total of 81 security state coefficients.  This would
require an adversary to develop 81 separate and colliding second
pre-images in order to avoid detection.

As we've noted previously, it is currently considered computationally
infeasible to create just one of these.

The following is probably not going to survive mail munging but here
is a jq formatted expression of one of these events, the wget binary
memory mapping its executable .text sections:

{
  "event": {
    "context": "6",
    "number": "978",
    "process": "wget",
    "type": "mmap_file",
    "ttd": "381",
    "p_ttd": "380",
    "task_id": "3e005861133608e71044ee178dbb891989dea6747ce8c0bc5928530a6902c48b",
    "p_task_id": "41274f59bfa217305cf2c529a70154e83e1a936798fa5ad5eb4ad9b7307cf1ab",
    "ts": "17463238151"
  },
  "COE": {
    "uid": "0",
    "euid": "0",
    "suid": "0",
    "gid": "0",
    "egid": "0",
    "sgid": "0",
    "fsuid": "0",
    "fsgid": "0",
    "capeff": "0x20000420"
  },
  "mmap_file": {
    "file": {
      "flags": "32800",
      "inode": {
        "uid": "2",
        "gid": "2",
        "mode": "0100755",
        "s_magic": "0xef53",
        "s_id": "xvdb",
        "s_uuid": "a953e99a39e54e478c9edf24815ddc49"
      },
      "path": {
        "dev": {
          "major": "202",
          "minor": "16"
        },
        "type": "namespace",
        "pathname": "/usr/bin/wget"
      },
      "digest": "55ceecbb3177e24872da8945660821943ab8fa17214637b5211d0dff5286e6b8"
    },
    "prot": "5",
    "flags": "5"
  }
}

If one reviews the COE and CELL characteristics in this expression you
will come to the conclusion that the attacker has no ability to modify
any of the event characteristics, in pursuit of masking this event as
an alternative good event.  So this single security event, among a
number of others of the 81, would generate a detectable model
violation and intrusion alert event.

In addition, any of the actions undertaken by the persistence shell
would have to be masked as known good events.  By definition the
persistence shell, and any of its subordinate processes, will have a
task identity different than any other process that Tomcat would run.

So every security event generated by these processes would need to be
masked as a known good event.  Once again with limited degrees of
freedom in the input domain.

Paul, we appreciate the significant demands on your time and the fact
that you have not been able to look at any of the code or
implementation details and no doubt by extension, to compile and test
a kernel and the userspace utilities to see what TSEM is actually
doing.

TSEM is a little bit like the Keccak/SHA3 hashing functions.  If you
follow the academic work of individuals attempting to study and defeat
the pre-image resistance of this family of functions, you will note
that they all comment that you have to work with the 'sponge
construction' that SHA3 is based on, to understand how difficult it is
to defeat.

> paul-moore.com

Apologies for the length of this note, but as you noted, this issue is
rather central to the security deliverables of TSEM.

I need to get on my cross-country skis.

Best wishes for a pleasant weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

[1]: Not that it means much, but I led a demonstration of the ability
to detect the Equifax exploit, with an earlier and more primitive
implementation of what has become TSEM.  In a Faraday shielded room at
what was to become DHS/CISA headquarters in the Glebe Building in
Arlington, Virginia, shortly before whatever it was then became CISA.
It was a successful demonstration, despite the fact that we were
depending on wireless networking that we brought with us to connect
back to our servers in the heartland... :-)
