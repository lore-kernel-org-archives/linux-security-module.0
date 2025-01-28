Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02AD19C566
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103048; cv=none; b=Zzs3NA3jyhRhRR53k7+0ovQVpSNNGPhTcu3wtYtO5hcJcCJ9Yzpe6+AAYNcxYjVMbw1sXqE6dKIB37OLDZP3a5Fsf9qvWhAWUy/hsoG/Un5YSXzpjKNdkWz3Ws1V+S5Mi/wMej8jaZVtc0rA59FIUiZ6lm4FakdJOa/9EkGQA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103048; c=relaxed/simple;
	bh=gxLdP8ZECOqwXIRloUG+zo39kATCJTipa9lhFWjtZ+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0gXm/dcF6I6LFycGl78YEm8rRQogrsm0eEjet7WIAQtrBSaDqasccVWdm3I5IWWAifftRbve1gRK0WWVZ4rQSqnANuFUmVaEWNqAb6AAWOzwpk0w3w8D/bvttRe28JIn7EZy6eOWNgjC1E5I0QAeh+6+Qux/EikNtnFmSjKEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GBHrKvJx; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GBHrKvJx"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so9442641276.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738103044; x=1738707844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZYyuKjs99sAEaCONDi+kRqqrC35ZQosZEYFZjUKU3I=;
        b=GBHrKvJxSlkFk4ofZsk+qkyZwizaqb0QzvcrjuicN+4J6n1OrCFQ4lTDxAS0BNsRC4
         77gjMhU+h39+LqzOXod+RMetvAx6awrZRlvAgUjcF+zF2AsBZQBb8GCxRHHg4ZcEa7j9
         UrJoJ5jhampRHK17w2ksVjd/W/khx7g4RhDCgUVSIbq8seLjgWMGwnycwWJ1KYeWIQVG
         8AIq+4QXBIbbftMQepCoEIIrh5ZdG9Hslwap5Hl84aTzn+ELfiwQ0r9IO8zhLFZuOMTQ
         bOnNBhsDkSVtQFothGdToMZMI2kAwgE2LAFdgYrxL5PyaCsZg9IHwr1AVyjGfPxeobhH
         1dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738103044; x=1738707844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZYyuKjs99sAEaCONDi+kRqqrC35ZQosZEYFZjUKU3I=;
        b=KOspnL9axZrmHoTucQR6gvSZg9SM/qwLkwleRtQC6AlsmEAjaCmwD/zaxczDf0O3L8
         p+NcWa7IoJakVLVa0mzYuBBYn6GNGmhY2OD8xueSMwnIjfzuB1RrZH5RY1OAI8UTHo9z
         mHqiUUmF87D+b7vaQLLoRp0J8S+zBHvRCWK4d4+zcrOPmMpFProSxwruzOQ/bQTVtmxd
         cdDQjETLeO03MYLxegLOmHT66z8l97eDZdikUCKTPsj+odGd+EOhzwtuGyBOsBQjaOx5
         8uohmLS5Pnm3Z6BACUgkb3bwEQmZzXTdgwCQLMs4N84aeoMS6kE+kXP14ImAMszIrsUY
         uDyQ==
X-Gm-Message-State: AOJu0Yx9kNvKEhpXBw1sFNRucfNukeAvb8L5e9mvlAr1vJjqfdSm4xHS
	SotSp2a+WjR3HKF2EuUPl/rGuRIG+FookwmWeJqpylNvg8XeS7OZVHwnSpx4eHvjdQQ8wSaN4qh
	knzwH7LPdAzc6wI1zEq6nixb3Y7lmsmEo1Hrd
X-Gm-Gg: ASbGncuSKCTUgOYPeVCvsiQofJMvyE3BqKQjKVbvyQfNwSLfsEjt3jrxmADjeB1YGTs
	sYcEsTPYw+9dckwGrjUGg67/kkQpZ13i0AqJI527GAHkoJeqengu/XWnhgkP0eGNz14dbFos=
X-Google-Smtp-Source: AGHT+IEGZXDmvBF3YRHcz+wsfLMatRJcCgLRR4eneN9Umu79NidjZpJH9oKSmunuoqd8QTFO0HLLC+NZ61Z4A+zXaw4=
X-Received: by 2002:a05:690c:f13:b0:6ee:6e71:e6d6 with SMTP id
 00721157ae682-6f7a8409b84mr6246067b3.23.1738103043510; Tue, 28 Jan 2025
 14:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250117044731.GA31221@wind.enjellic.com>
In-Reply-To: <20250117044731.GA31221@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Jan 2025 17:23:52 -0500
X-Gm-Features: AWEUYZlYnwReUGiAD6mjc_4OMFPdOPhH9g3IIq3cSqd3eOpf8H1xQg3zO5x42W8
Message-ID: <CAHC9VhTphGpnVNPkm0P=Ndk84z3gpkJeg90EAJiJEyareLUVTA@mail.gmail.com>
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:47=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote=
:
> On Mon, Jan 13, 2025 at 08:29:47PM -0500, Paul Moore wrote:
> > On Aug 26, 2024 Greg Wettstein <greg@enjellic.com> wrote:
> > >
> > > An entry was added to the ABI testing documentation to document the A=
PI
> > > definitions for the TSEM ontrol plane.
> > >
> > > The file documenting the kernel command-line parameters was
> > > updated to document the TSEM specific parameters that are
> > > implemented.
> > >
> > > The primary TSEM documentation file was added to the LSM
> > > administration guide and the file was linked to the index of LSM
> > > documentation.
> > >
> > > ---
> > >  Documentation/ABI/testing/tsem                | 2420 +++++++++++++++=
++
> > >  Documentation/admin-guide/LSM/index.rst       |    1 +
> > >  Documentation/admin-guide/LSM/tsem.rst        | 1680 ++++++++++++
> > >  .../admin-guide/kernel-parameters.txt         |   29 +
> > >  4 files changed, 4130 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/tsem
> > >  create mode 100644 Documentation/admin-guide/LSM/tsem.rst

...

> > > +Security Event Modeling
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +
> > > +   "We can no longer speak of the behavior of the particle
> > > +    independently of the process of observation. As a final
> > > +    consequence, the natural laws formulated mathematically in
> > > +    quantum theory no longer deal with the elementary particles
> > > +    themselves but with our knowledge of them. Nor is it any
> > > +    longer possible to ask whether or not these particles exist in
> > > +    space and time objectively ... When we speak of the picture of
> > > +    nature in the exact science of our age, we do not mean a
> > > +    picture of nature so much as a picture of our relationships
> > > +    with nature.  ...Science no longer confronts nature as an
> > > +    objective observer, but sees itself as an actor in this
> > > +    interplay between man and nature. The scientific method of
> > > +    analysing, explaining and classifying has become conscious of
> > > +    its limitations, which arise out of the fact that by its
> > > +    intervention science alters and refashions the object of
> > > +    investigation. In other words, method and object can no longer
> > > +    be separated."
> > > +                           - Werner Karl Heisenberg
> > > +
> > > +Security Event Modeling (SEM), is an alternative strategy to impleme=
nt
> > > +the security guarantees of mandatory access and integrity controls, =
in
> > > +a manner that is consistent with emerging application development
> > > +strategies such as namespaces and CI/CD workflows.
> > > +
> > > +As was noted at the start of this document, the premise for SEM is
> > > +that the security behavior of a platform, or alternatively a workloa=
d,
> > > +can be modeled like any other physical phenomenon in science and
> > > +engineering.
> > > +
> > > +Inspiration for this came from the primary TSEM author/architect
> > > +having trained as a quantum chemist, conducting very early research =
in
> > > +the development of multi-scale modeling strategies for molecules of
> > > +size to be of interest to pharmaceutical intents.
> > > +
> > > +SEM is premised on the theory that kernel security architects have
> > > +instrumented the LSM security event hooks to be called in locations
> > > +before security sensitive operations are conducted, with appropriate
> > > +descriptive parameters, that are considered relevant to the security
> > > +posture of the kernel.  With respect to modeling, the security event
> > > +hooks are conceptualized as representing the independent variables o=
f
> > > +a basis set that yields a functional definition for the security sta=
te
> > > +of an execution trajectory.
> > > +
> > > +SEM can be framed in the context of classic subject/object mandatory
> > > +access controls, by the notion that a unique identity can be generat=
ed
> > > +for each element of an access vector matrix, rather than a boolean
> > > +value.  In SEM, a security execution trajectory is defined by the se=
t
> > > +of security state coefficients that a process hierarchy (workload)
> > > +generates.  This execution trajectory produces a vector of identitie=
s,
> > > +whose sum in an appropriate form, yields a functional definition of
> > > +the security state of the system.
> > > +
> > > +Two subordinate identities are combined to yield a security event
> > > +state coefficient.  These subordinate identities are referred to as
> > > +the Context Of Execution (COE) and the CELL, which are conceptually
>
> > Please define the CELL acronym here as I believe it is the first use of
> > "CELL" in this document.
>
> FWIW, CELL isn't an acronym, it is a metaphor.

My mistake.  I know how hard naming can be, so if you feel like "CELL"
is the best choice here I'm not going to object, however, I think it
is worth a mention that in our acronym heavy industry any term that is
presented in all caps is often seen as an acronym and not a metaphor.

> > > +The Linux TSEM Implementation
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +   "Sometimes the questions are complicated and the answers are
> > > +    simple."
> > > +                           - Dr. Seuss
> > > +
> > > +The Linux TSEM implementation is deliberately simplistic and consist=
s
> > > +of the following two generic components:
> > > +
> > > +- Security modeling namespace and security event export functionalit=
y.
> > > +
> > > +- Internal trusted modeling agent implementation.
> > > +
> > > +The security modeling namespace and export functionality is designed
> > > +to be generic infrastructure that allows security namespaces to be
> > > +created that are either internally or externally modeled.  The TSEM
> > > +implementation does not pose any constraints on what type of modelin=
g
> > > +can or should be implemented in these namespaces.
> > > +
> > > +On the theory that security event handlers represent all of the
> > > +security relevant action points in the kernel, any security or
> > > +integrity model can be implemented using the TSEM infrastructure.  F=
or
> > > +example, basic IMA functionality could be implemented by a TMA that
> > > +maps the digests of files accessed, or mapped executable, by the roo=
t
> > > +user as the security state coefficients.
>
> > In order to keep the peace among different LSMs, we try very hard to
> > avoid language along the lines of "LSM A could be implemented by LSM
> > B".  Please refrain from such language, especially in documentation
> > that lives within the kernel.
>
> We were not suggesting superiority or replacement, our apologies to
> the community if the above would be perceived as such.

My recommendation is to simply avoid any mention of other LSMs.  Not
only does it avoid any unforeseen negative comparisons, it also
encourages the documentation to fully explain the LSM without having
to rely on an understanding of another, which could result in its own
set of problems.

> In fact, the upcoming V5 release and its associated userspace tools,
> have a proof of concept implementation of TOMOYO as a TSEM loadable
> module, as a further indication of its ability to lowering the
> barriers to the development of alternative or customized security
> architectures.

Ignoring any technical issues for a moment, I would strongly suggest
against that approach for the reasons given above.  I can appreciate
that your intent is likely to demonstrate the capabilities of TSEM,
but doing so by emulating an existing LSM sets a bad precedent and I
will not view it positively.

> > > +Internal vs external modeling
> > > +-----------------------------
> > > +
> > > +When a TSEM security modeling namespace is created, a designation is
> > > +made as to whether the namespace is to be internally or externally
> > > +modeled.
> > > +
> > > +In an internally modeled namespace, the security event handlers pass=
 the
> > > +event type and its characteristics to the designated internal truste=
d
> > > +modeling agent.  The agent provides the permission value for the
> > > +security event handler to return as the result of the event and sets
> > > +the trust status of the process executing the event.
> > > +
> > > +In an externally modeled namespace, the event type and parameters ar=
e
> > > +exported to userspace for processing by a trust orchestrator with an
> > > +associated TMA.  The trust orchestrator communicates the result of t=
he
> > > +modeling back to the kernel to support the setting of the process
> > > +trust status.
> > > +
> > > +The exception to this model are for security event handlers that are
> > > +called in atomic, ie. non-sleeping context.  The export of these
> > > +security event descriptions are done asynchronously in order to avoi=
d
> > > +having the TSEM implementation attempt to sleep in atomic context
> > > +while the userspace trust orchestrator is scheduled for execution.
> > > +
> > > +It is up to the trust orchestrator and its security policy to
> > > +determine how it handles events that violate the security model bein=
g
> > > +enforced in this model.  The Quixote trust orchestrators shut down t=
he
> > > +entire workload running in the security namespace if an asynchronous=
ly
> > > +modeled event violates the security model being enforced and the mod=
el
> > > +is running in enforcing mode.
>
> > I understand your desire to simply pass off the non-blocking/async
> > access control hole as a security policy issue, but it seems to me
> > that this is a fundamental flaw with an externally modeled TSEM
> > namespace.  If an externally modeled namespace was configured with
> > an enforcing policy, it doesn't appear that there is a mechanism for
> > TSEM to properly enforce that policy as there is an unbounded delay
> > between the undesired access and a denial verdict being processed by
> > the kernel.
> >
> > Unless you can resolve this somehow, and I'm not sure how, I would
> > suggest dropping external/userspace trust orchestrators.  They
> > simply don't seem able to reliably implement their security
> > policies.
>
> An important issue.
>
> Some reflections on why we would, respectfully, disagree.
>
> A business assessment of the current security market suggests that the
> mindset in security has changed from prevention to detection.  TSEM is
> about providing kernel infrastructure to enable better solutions for
> the detection model.

I believe the LSM can support both the enforcement of security policy
and the observation of security relevant events on a system.  In fact
most of the existing LSMs do both, at least to some extent.

However, while logging of security events likely needs to be
asynchronous for performance reasons, enforcement of security policy
likely needs to be synchronous to have any reasonable level of
assurance.  You are welcome to propose LSMs which provide
observability functionality that is either sync, async, or some
combination of both (? it would need to make sense to do both ?), but
I'm not currently interested in accepting LSMs that provide
asynchronous enforcement as I don't view that as a "reasonable"
enforcement mechanism.

> > > +In order to handle modeling of security events in atomic context, th=
e
> > > +TSEM implementation maintains caches (magazines) of structures that
> > > +are needed to implement the modeling and export of events.  The size
> > > +of this cache can be configured independently for each individual
> > > +security modeling namespace that is created.  The default
> > > +implementation is for a cache size of 32 for internally modeled
> > > +namespaces and 128 for externally modeled namespaces.
> > > +
> > > +By default the root security namespace uses a cache size of 128.  Th=
is
> > > +value can be configured by the 'tsem_cache' kernel command-line
> > > +parameter to an alternate value.
>
> > I haven't looked at the implementation yet, but I don't understand
> > both why a kmem_cache couldn't be used here as well as why this
> > implementation detail is deemed significant enough to be mentioned
> > in this high level design document.
>
> TSEM does use kmem_cache allocations for all of its relevant data
> structures.
>
> The use of a kmem_cache, however, does not solve the problem for
> security event handlers that are required to run in atomic context.
> To address the needs of those handlers you need to serve the
> structures out of a pre-allocated magazine that is guaranteed to not
> require any memory allocation or sleeping locks.

This still seems somewhat suspicious as there are a couple of GFP
flags that allow for non-blocking allocations in all but a few cases,
but I'll defer further discussion of that until I get to the code.  In
my opinion, there are still enough red flags in these documentation
reviews to keep me from investing the time in reviewing the TSEM code.

Regardless, I stand by my previous comment that discussion of these
caches may be a bit more detail that is needed in this document, but
of course that is your choice.  It's a balancing act between providing
enough high level detail to satisfy users and reviewers, and producing
a document that is so verbose that the time required to properly
review it is prohibitive.

> > > +Trust Orchestrator/Process authentication
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +The process identifier values (PID's) that are exported in the
> > > +security event descriptions are the unique global PID values, not th=
e
> > > +value as seen through the lens of a PID namespace.
> > > +
> > > +PID values are, by default, not considered to be a stable identifier
> > > +between the kernel and userspace.  In the case of TSEM external
> > > +modeling, the threat model for a namespace is whether or not an
> > > +adversarial process, running in either the root security modeling
> > > +namespace or another subordinate security modeling namespace, can ki=
ll
> > > +a process that is being orchestrated and substitute an alternate
> > > +process with an identical PID value.
>
> > We've talked about this previously, but given my current
> > understanding of TSEM, one of my concerns is the presence of user
> > controlled data in a TSEM security event.  This could include PIDs,
> > task->comm values, and potentially others (I haven't gone through
> > the full CELL list yet).
>
> Point one: we don't use task->comm values, or PID's, in the generative
> models.

Yet a PID is still exported to an external orchestrator.

> > > +Event modeling
> > > +--------------
> > > +
> > > +The generation of security state coefficients is a functional proces=
s
> > > +that uses a cryptographic hash function for the creation of the
> > > +individual identity mappings that contribute to the generation of th=
e
> > > +security state coefficient.
> > > +
> > > +TSEM can use any cryptographic hash function available to the Linux
> > > +kernel for this purpose.  The hash function to be used for a securit=
y
> > > +modeling namespace is specified as a parameter to the namespace
> > > +creation process.
> > > +
> > > +By default, the root security namespace uses sha256.  This value can
> > > +be modified through the tsem_digest kernel command-line parameter.
> > > +
> > > +Since TSEM is active before the kernel has the ability to load
> > > +modules, the root modeling domain must be a cryptographic hash
> > > +function that is statically compiled into the kernel.  By default th=
e
> > > +TSEM configuration selects for the presence of the sha256 hash
> > > +function.
> > > +
> > > +TSEM security event modeling is based on the following functional
> > > +definition for a security event coefficient:
> > > +
> > > +Coeff =3D HF(HF(EVENT_ID) || PTASK_ID || TASK_ID || HF(COE) || HF(CE=
LL))
> > > +
> > > +   Where:
> > > +           Coeff    =3D A security state coefficient that is equal
> > > +                      in length to the digest value of the
> > > +                      cryptographic hash function in use for the
> > > +                      security modeling namespace.
> > > +
> > > +           HF       =3D Security namespace specific hash function.
> > > +
> > > +           ||       =3D Concatenation operator.
> > > +
> > > +           EVENT_ID =3D The ASCII name of event.
> > > +
> > > +           PTASK_ID =3D The TASK_ID of the parent process of the
> > > +                      process represented by TASK_ID.
> > > +
> > > +           TASK_ID  =3D The process specific identity of the
> > > +                      executable code that is calling the security
> > > +                      event handler.
> > > +
> > > +           COE      =3D Characteristics of the context of execution
> > > +                      of the event.
> > > +
> > > +           CELL     =3D Characteristics of the LSM event that is bei=
ng
> > > +                      modeled.
> > > +
> > > +Workload or platform specific security state coefficient definitions
> > > +are generated by a TMA, using the COE or CELL characteristics that a=
re
> > > +considered relevant for the model being implemented.  These
> > > +coefficients are used to determine whether or not an event should le=
ad
> > > +to the process being considered trusted or untrusted.
> > > +
> > > +The TASK_ID component of the function above is important with respec=
t
> > > +to the generation of the security state coefficients.  The notion of=
 a
> > > +task identity serves to link the concepts of system integrity and
> > > +security access control.
> > > +
> > > +The TASK_ID is defined by the following function:
> > > +
> > > +TASK_ID =3D HF(HF(EVENT) || PTASK_ID || NULL_ID || HF(COE) || HF(CEL=
L))
> > > +
> > > +   Where:
> > > +           TASK_ID   =3D The executable identity of the process
> > > +                       expressed as a digest value of length
> > > +                       equal to the cryptographic hash function
> > > +                       the security modeling namespace is using.
> > > +
> > > +           HF        =3D Security namespace specific hash function.
> > > +
> > > +           ||        =3D Concatenation operator.
> > > +
> > > +           EVENT     =3D The string "bprm_committed_creds".
> > > +
> > > +           PTASK_ID  =3D The TASK_ID of the parent process of the
> > > +                       process whose TASK_ID is being generated.
> > > +
> > > +           NULL_ID   =3D A buffer of null bytes equal to the digest
> > > +                       size of the hash function being used for
> > > +                       the namespace.
> > > +
> > > +           COE       =3D Characteristics of the context of execution
> > > +                       calling the bprm_committed_creds LSM hook.
> > > +
> > > +           CELL      =3D The characteristics of the file provided
> > > +                       by the linux_binprm structure passed to
> > > +                       the security_bprm_committed_creds handler.
> > > +
> > > +An attentive reader will quickly conclude, correctly, that the TASK_=
ID
> > > +function generates an executable specific security coefficient for t=
he
> > > +bprm_committed_creds security hook.  The generative function for the
> > > +TASK_ID is the same as the standard security state coefficient; with
> > > +the exception that the task identity is replaced with a 'null id',
> > > +consisting of the number of null bytes in the digest size of the
> > > +namespace specific hash function.
> > > +
> > > +One of the CELL characteristics used in the computation of the task
> > > +identity is the digest of the executable file.  Modifying an
> > > +executable, or attempting to execute a binary not considered in the
> > > +security model, will result in an alteration of the task identity th=
at
> > > +propagates to the generation of invalid state coefficients.
>
> > Presumably an attacker could craft a malicious executable (or
> > influence the CELL value if it incorporates user controlled values)
> > that collides with the digest of a known and trusted application.
>
> An incredibly important issue, so apologies for a more lengthy reply
> on this issue.
>
> More precisely, the objective for an adversary would be to generate
> the same security coefficient for a specific security event type using
> an alternative ensemble of operating system relevant characteristics
> for the event.
>
> The generative functions for the COE, CELL, task identities and
> ultimately the security state coefficients, are based on industry
> standard cryptographic hash functions.  The attack scenario suggested
> above would represent a major failure in the second pre-image
> resistance characteristics of these industry standard security
> primitives.
>
> The ability to decept these security primitives, in such a manner,
> would represent a crisis for the entire technology industry.

Look around, it is happening now.  Of course the level of risk varies
tremendously based on the application and yes, the chosen hash
function.  However, given the composition of TSEM's CELL value in some
events, and the importance of a hashed event value in TSEM's
policy/model enforcement, it seems like this is something that one
would want to address.

> > > +Security model functional definitions
> > > +-------------------------------------
> > > +
> > > +Previously, classic trusted system implementations supported the
> > > +notion of the 'measurement' of the system.  The measurement is the
> > > +value of a linear extension function of all the security relevant
> > > +actions recorded by a trust measurement system such as IMA.
> > > +
> > > +In TPM based trust architectures, this measurement is maintained in =
a
> > > +PCR.  A measurement value is submitted to the TPM that extends the
> > > +current measurement using the following formula:
> > > +
> > > +MEASUREMENT =3D HF(CURRENT || NEW)
> > > +
> > > +   Where:
> > > +           MEASUREMENT =3D The new measurement value to be maintaine=
d
> > > +                         in the register for the system.
> > > +
> > > +           HF          =3D A cryptographic hash function supported
> > > +                         by the TPM device.
> > > +
> > > +           ||          =3D Concatenation operator.
> > > +
> > > +           CURRENT     =3D The current measurement value.
> > > +
> > > +           NEW         =3D A new measurement value to be added to
> > > +                         the current measurement.
> > > +
> > > +The use of a cryptographic function produces a non-commutative sum
> > > +that can be used to verify the integrity of a series of measurements=
.
> > > +With respect to security modeling theory, this can be thought of as =
a
> > > +'time-dependent' measurement of the system.  Stated more simply, the
> > > +measurement value is sensitive to the order in which the measurement=
s
> > > +were made.
> > > +
> > > +In systems such as IMA, the measurement value reflects the sum of
> > > +digest values of what are considered to be security critical entitie=
s,
> > > +most principally, files that are accessed or memory that is mapped
> > > +executable, based on various policies.
> > > +
> > > +In TSEM based TMA's, the measurement of a security modeling namespac=
e
> > > +is the sum of the unique security state coefficients generated by th=
e
> > > +security model being enforced.  As previously noted, on systems with=
 a
> > > +TPM, the root security modeling namespace measurement is maintained =
by
> > > +default in PCR 11 or the PCR that was selected at kernel configurati=
on
> > > +time.
> > > +
> > > +The challenge associated with classic integrity measurements is the
> > > +time dependent nature of using a non-commutative summing function.
> > > +The almost universal embrace of SMP based hardware architectures, in
> > > +addition to standard kernel task scheduling issues, makes the
> > > +measurement values non-deterministic.  This requires a verifying par=
ty
> > > +to evaluate an event log, verified by a measurement value, to
> > > +determine whether or not the system is in a security appropriate or
> > > +trusted state.
> > > +
> > > +TSEM addresses this issue by implementing a strategy designed to
> > > +produce a single functional value that represents the functional
> > > +security state of a model.  This allows a TMA to attest to the
> > > +trust/security status of a platform or workload by signing this
> > > +singular value and presenting it to a verifying party.
> > > +
> > > +In TSEM nomenclature, this functional value is referred to as the
> > > +'state' of the model.  The attestation model is to use trust
> > > +orchestrators to generate the state value of a workload by unit
> > > +testing.  This state value can be packaged with a utility or contain=
er
> > > +to represent a summary trust characteristic that can be attested by =
a
> > > +TMA, eliminating the need for a verifying partner to review and veri=
fy
> > > +an event log.
> > > +
> > > +TMA's implement this architecture by maintaining a single instance
> > > +vector of the set of unique security state coefficients that have be=
en
> > > +experienced in a security modeling namespace.  The state measurement
> > > +is generated by sorting the security state coefficient vector in
> > > +big-endian hash format and then generating a standard linear extensi=
on
> > > +measurement over this new vector.
>
> > There are cases where ordering of events is important when assessing
> > the security state of the system, e.g. disabling/enabling security
> > features.  In these cases where ordering is necessary to attest the
> > security state of the system, is there some middle ground, or does
> > an admin need to revert to a "classic" orderered measurement?
>
> If the time order of two security critical events is important, the
> only thing that can be done is to evalute which event occurred first.
>
> TSEM now facilitates this by including nanosecond timestamp
> measurements of when each event occurred, see the 'ts' key value in
> the JSON 'event' description structure.
>
> Someone wishing to appraise the security status of a time dependent
> TSEM model would verify that the timestamps on the two event
> descriptions are ordered properly.

In those cases I do have to wonder if most of TSEM's advantages are now los=
t.

> > > +Any security event that generates an associated state coefficient th=
at
> > > +is not in the model will resulted in a perturbed state function valu=
e.
> > > +That perturbed value would be interpreted by a verifying party as an
> > > +indication of an untrusted system.
> > > +
> > > +Since the TMA maintains the security event descriptions in time
> > > +ordered form, the option to provide a classic event log and
> > > +measurement are preserved and available.  Extensive experience in th=
e
> > > +development of TSEM modeled systems has demonstrated the superiority
> > > +of state value interpretation over classic measurement schemes.
>
> > I don't disagree that working with the pre-sorted measurement is far
> > easier, I just wonder how many systems would be able to give up on
> > the event ordering to have the simplified modeling.  Surely we will
> > all have different experiences here, but I'm not sure the pre-sorted
> > measurement approach would have been acceptable in many of the
> > projects I've worked on over the years.
>
> Three general observations.
>
> Roberto's work on Integrity Digest Caches would suggest that other
> groups feel that non-temporal assessments are of value.

The integrity digest caching functionality isn't a security policy,
it's a cache that improves integrity measurements/verifications in
some use cases.  It's an implementation improvement, not a security
model.

> The 'real' world consists of shades of grey.  In earlier reviews you
> questioned why TSEM was delivering ordered as well as unordered
> measurement trajectories.  The reason we provide both is to support
> the grey world we must function in.

My argument was that TSEM was putting forth unordered measurements as
a solution to all that ails existing ordered measurement solutions, so
it made little sense to include ordered measurements if the TSEM
solution was superior.  I think the reality is that unordered
measurements look appealing on paper, and perhaps even have a few use
cases that can leverage these benefits without having to worry about
the downsides, but they aren't going to be a reasonable solution for a
large number of use cases.  This raises a question of why include
both?  The unordered approach may be novel, but is it applicable
enough to warrant the added complexity?

> > > +Control plane
> > > +-------------
> > > +
> > > +Both primary functions of TSEM: security modeling namespace manageme=
nt
> > > +and the internal TMA modeling implementation, are controlled by
> > > +pseudo-files in the securityfs filesystem.  The following directory
> > > +is the top level implementation directory for the TSEM control plane=
:
> > > +
> > > +/sys/kernel/security/tsem
> > > +
> > > +The following file in the kernel source tree documents, in detail,
> > > +the interfaces provided by the filesystem:
> > > +
> > > +Documentation/ABI/testing/tsem
> > > +
> > > +This filesystem is primarily intended for use by trust orchestrators
> > > +to create and manage security modeling namespaces.
> > > +
> > > +The files are process context sensitive.  Writing to the control fil=
e,
> > > +or reading from the informational files, will act on or reference th=
e
> > > +security modeling namespace that the accessing process is assigned t=
o.
> > > +
> > > +The following files are provided in the root directory of the TSEM
> > > +control plane and implement global controls for the TSEM LSM:
> > > +
> > > +   aggregate
> > > +   id
> > > +   control
> > > +
> > > +The 'aggregate' file is used by trust orchestrators for internally
> > > +modeled namespaces to obtain the hardware measurement value for
> > > +inclusion in a security model.
>
> > So I'm clear on this, internally modeled namespaces still access the
> > hardware measurement directly from inside the kernel, yes?  In the
> > interally modeled case this is simply available as a reference, and
> > the in-kernel TMA doesn't call out to userspace to access this value,
> > yes?
>
> Correct.
>
> > > +A trust orchestrator for an externally
> > > +modeled namespace capture this value as the first event generated by=
 a
> > > +security modeling namespace.
> > > +
> > > +The 'id' file is used to determine the security modeling namespace
> > > +that the process is running in.  The namespace id value of 0 is
> > > +reserved for the root security modeling namespace, a non-zero value
> > > +indicates that the process is running in a subordinate security
> > > +modeling namespace.
> > > +
> > > +The TSEM implementation is controlled by the only writable file, whi=
ch
> > > +is the 'control' file.
> > > +
> > > +The following keywords are used by trust orchestrators to place the
> > > +process writing to the file in an internally or externally modeled
> > > +security namespace:
> > > +
> > > +   internal
> > > +   external
> > > +
> > > +Each argument accepts key=3Dvalue pairs that configure the namespace=
.
> > > +The following key values are currently accepted:
> > > +
> > > +   model
> > > +   nsref
> > > +   digest
> > > +   cache
> > > +   key
> > > +
> > > +The 'model' keyword takes as an argument the name of a loadable modu=
le
> > > +that will be used to implement the event processing for a security
> > > +modeling namespace.  If the module has not already been loaded, TSEM
> > > +will attempt to dynamically load the module.
>
> > I'm still sorting out the stuff in the docs and haven't gotten to
> > the implementation yet, but just so we're clear on the details about
> > TSEM modules, TSEM shouldn't attempt to sidestep the LSM framework
> > as TOMOYO did recently and we later had to revert.
>
> We were active in those discussions and are on record with respect to
> supporting the notion that LSM's should not attempt to sidestep the
> LSM infrastructure.
>
> TSEM operates entirely within the LSM framework.  TSEM loadable
> modules were implemented in order to allow shaping of the event
> mapping to allow multiple types of models to be implemented.

Another area where one might question the tradeoff between complexity
and capability.

> > Considering that TSEM is likely to want to be active before enough
> > of a userspace exists to load a module (see the previous sections on
> > hash functions), it seems like the best option is to simply include
> > all of the desired internal TMAs in the kernel at build time.
>
> Our experience in building solutions in this space is to have a very
> minimal orchestration environment running in the root modeling
> namespace that sets up the host and is modeled by the default
> deterministic TMA.
>
> The orchestration environment then runs containerized workloads in
> independent modeling namespaces that benefit from the availability of
> multiple models, including the simple export of security events for
> external EDRS evaluation.
>
> > > +If the standard practice
> > > +is followed of using the KBUILD_MODNAME CPP define to set the name o=
f
> > > +the security model, the argument to the model keyword will be that
> > > +name, a value that will match the name that is displayed by the lsmo=
d
> > > +command.  It should be noted that there is no requirement that the
> > > +security model name match the name of the module generated by the
> > > +build process.
> > > +
> > > +The 'nsref' keyword takes one of the following two values:
> > > +
> > > +   initial
> > > +   current
> > > +
> > > +The initial argument indicates that the UID/GID values for the COE a=
nd
> > > +CELL characteristics are derived from the initial user namespace.
> > > +This is the default characteristic if the nsref key is not specified=
.
> > > +
> > > +The current argument indicates that the UID/GID values are derived
> > > +from the user namespace that the process is running in, when the
> > > +request is made to model an event.
> > > +
> > > +The 'digest' keyword is used to specify the cryptographic hash
> > > +function that is to be used to create the functional values for the
> > > +security state coefficients for the namespace.  The value to this
> > > +keyword is the name by which the hash function is defined by the
> > > +cryptographic API in the kernel.
> > > +
> > > +Examples of suitable strings are as follows:
> > > +
> > > +   sha256
> > > +   sha3-256
> > > +   sm3
> > > +
> > > +Definitions for the names of the cryptographic hashes can be found i=
n
> > > +the source files for the various cryptographic hash functions in the
> > > +'crypto' directory of the Linux source tree.
> > > +
> > > +The 'cache' keyword is used to specify the size of the caches used t=
o
> > > +hold pointers to data structures used for the internal modeling of
> > > +security events or the export of the security event to external trus=
t
> > > +orchestrators.  These pre-allocated structures are used to service
> > > +security event hooks that are called while the process is running in
> > > +atomic context and thus cannot sleep in order to allocate memory.
> > > +
> > > +The argument to this keyword is a numeric value specifying the numbe=
r
> > > +of structures that are to be held in reserve for the namespace.
> > > +
> > > +By default the root security modeling namespace and externally model=
ed
> > > +namespaces have a default value of 128 entries.  An internally model=
ed
> > > +namespace has a default value of 32 entries.  The size requirements =
of
> > > +these caches can be highly dependent on the characteristics of the
> > > +modeled workload and may require tuning to the needs of the platform
> > > +or workload.
>
> > Presumably TSEM provides usage statistics somewhere so admins can
> > monitor and tune as desired?  If so, it seems like it would be a
> > good idea to add a reference here.
>
> We have trended toward the Linus philosophy of reducing the need to
> worry about properly tuning knobs.

I agree that generally speaking the less tuning knobs to get wrong,
the better.  However, that assumes a system that can adjust itself as
necessary to ensure a reasonable level of operation.  If TSEM can not
dynamically adjust itself you should consider exposing those tunables.

--=20
paul-moore.com
