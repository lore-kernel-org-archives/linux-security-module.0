Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6FC678D4
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Mar 2023 04:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCCEQZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Mar 2023 23:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCCEQN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Mar 2023 23:16:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC5A25E3A
        for <linux-security-module@vger.kernel.org>; Thu,  2 Mar 2023 20:16:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u5so1472085plq.7
        for <linux-security-module@vger.kernel.org>; Thu, 02 Mar 2023 20:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677816968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMM0hCHISGTZUzRIQcxQJd1qhLjbu+yCnhJfUOdTUos=;
        b=B9Ltnf5BWSf15RNpS0GPnNkrYqJBwu9OAM0m7gVOJMI+rj+kZ0hZ6+O6z7LSuz9Vf2
         1+EMI9Mu1jwfwVF7UhgKNcfjHJ+EI8wnXYy4Wo4gl6PVl0RLi5tR8ME4y3QoOHemDyNr
         82+Ez32Ww/0sgxq57+40ZloiDfz5SUJEAzk7Ecj72e3ubtlX6eQVowEZOIIsLWBxh9Ap
         QWyyACNAIlpF8H+DNKfvAxkr6EJuYtA5IQ1KWmOL8Am0Q8DLl+BmyxKw+zBwVq3OrKL+
         I+trfr3d5XPXX58fBr9VaC2KzyVFEwLsO9PjGq2g+Vplefy1P/wnUFo0ghR7QGXuTESq
         /LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677816968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMM0hCHISGTZUzRIQcxQJd1qhLjbu+yCnhJfUOdTUos=;
        b=Js/mrHhBUvxOCtSxlkGUtYcd6LPJbqMxSzReqYqhG3oLzKK1OfTCb8SMdffbhjTI6b
         xpk/WCt3+ttvFYVJH/4FRUc1VzRavvrB39pzCMz7U+tFcJDLyGT3Cx7AMESqkKA9N1DL
         Aet9i20IhxqxuTVV1nux97/9UVnXX4GmI19PKCiuuufQbjdxFygzsJLO/aI4DDBBHpEG
         XMNKS8XT+bgw8IQPg1uKH0pOzxsiXuc/dZOABGVOSGzhOR2VfjJaQ4mWjI8cLvSpXCwR
         e9NtgUJp+8bmF4P8FzsxpMkez0MN66rE1V8Jf0W1M7TuG/+fdc7T1e3a8LCjAVNL6Bwx
         DSFg==
X-Gm-Message-State: AO0yUKX/xIXs1xF5JVQjymZP+K+ZX7Tjt/mpyqUcX7V/vI2xn+nf6bsh
        obxcbwiFCBQTV4Wr92sinVfPFtm2uVrMaitEfUaX7AzuNx2n/dY=
X-Google-Smtp-Source: AK7set/OwQ21JMcgeKnKxBsD3q5ac5A+w1ueoppS7CN0tPtuZjrMZWsmnKdW3+dumJog8JNNkinb5qB+WtSlw9UB+ds=
X-Received: by 2002:a17:903:281:b0:19a:fdca:e3f1 with SMTP id
 j1-20020a170903028100b0019afdcae3f1mr249724plr.3.1677816967534; Thu, 02 Mar
 2023 20:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com>
 <CAHC9VhQnZhczVRifSnM-zv46Cb9OFuh=6ha+1zKJaOUK15=K5A@mail.gmail.com> <20230214115822.GA28408@wind.enjellic.com>
In-Reply-To: <20230214115822.GA28408@wind.enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Mar 2023 23:15:56 -0500
Message-ID: <CAHC9VhQoj-aWrN5SxfkT2zaNmaKCG7VyYVvGsaHAbp5iA8OBZw@mail.gmail.com>
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 14, 2023 at 6:58=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
> On Sun, Feb 12, 2023 at 11:33:26PM -0500, Paul Moore wrote:
> > On Sat, Feb 4, 2023 at 12:33 AM Dr. Greg <greg@enjellic.com> wrote:
> > >
> > > An entry was added to the ABI testing documentation to document
> > > the files in the TSEM management filesystem.
> > >
> > > The file documenting the kernel command-line parameters was
> > > updated to document the tsem_mode command-line parameter.
> > >
> > > The primary TSEM documentation file was added to the LSM
> > > administration guide and the file was linked to the index of LSM
> > > documentation.
> > >
> > > Signed-off-by: Greg Wettstein <greg@enjellic.com>
> > > ---
> > >  Documentation/ABI/testing/tsemfs              |  576 ++++++++
> > >  Documentation/admin-guide/LSM/index.rst       |    1 +
> > >  Documentation/admin-guide/LSM/tsem.rst        | 1240 +++++++++++++++=
++
> > >  .../admin-guide/kernel-parameters.txt         |    5 +
> > >  4 files changed, 1822 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/tsemfs
> > >  create mode 100644 Documentation/admin-guide/LSM/tsem.rst
>
> > One of the more important requirements for any new LSM is that it
> > documents a clear, understandable, and reasonable security model along
> > with an implementation that faithfully implements that model.  Before
> > I looked at your code I wanted to try and understand the TSEM security
> > model and a few things jumped out at me rather quickly, I imagine
> > there would be others as I start to look a bit closer but I wanted to
> > send these questions/comments along now to get your take on them ...
>
> Hi Paul, thanks for taking time to review the documentation and raise
> questions, responses below.
>
> > > diff --git a/Documentation/ABI/testing/tsemfs b/Documentation/ABI/tes=
ting/tsemfs
> > > new file mode 100644
> > > index 000000000000..3d326934624c
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/tsemfs

...

> > > +What:          /sys/fs/tsem/measurement
> > > +Date:          November 2022
> > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > +Description:
> > > +               The measurement file contains the ASCII base 16
> > > +               hexadecimal representation of the 256 bit measurement
> > > +               value of the security model that the process is
> > > +               operating in.
> > > +
> > > +               The measurement value is the classic linear extension
> > > +               measurement of the model.  An updated measurement
> > > +               value is created by extending the current measurement
> > > +               value with the state coefficient computed for a
> > > +               security event.
> > > +
> > > +               This measurement value represents a time dependent
> > > +               measurement of a model and is susceptible to
> > > +               deviations caused by scheduling differences between
> > > +               subsequent invocations of a workload.
>
> > Given the very volatile nature of this value, what is it used for in
> > userspace?  My apologies if I missed it in the docs.
>
> It serves the same role as PCR register 10 in IMA, or any other
> register in a TPM based architecture using a classic linear extension
> mechanism strategy, it can be used to validate a list of time or
> sequence ordered measurement values.
>
> Our personal prejudice is that these types of measurements are of
> limited value, which is why we introduce in TSEM, the notion of the
> 'state' value for a model, discussed below.
>
> I would have to go looking on lore for a reference to the exact thread
> but Roberto Sassu had offered up a patch set for IMA that addressed
> the deficiency of these types of measurements.

If we all agree that this measurement isn't very useful, and you have
implemented an alternative which is intended to address these
usability shortcomings, why bother including this measurement in TSEM?

It's relatively easy to add features to the Linux Kernel as time goes
on, it is *very* difficult to remove them.  For this initial
submission I would encourage you to implement the bare minimum
functionality you need to do something useful and meet your goals.

> > > +What:          /sys/fs/tsem/points
> > > +Date:          November 2022
> > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > +Description:
> > > +               The points file contains the ASCII base 16
> > > +               representation of the 256 bit security state points o=
f
> > > +               a security domain/model.  The number of entries in
> > > +               this file represent the number of security events tha=
t
> > > +               are represented by the model.
>
> > A similar questions to the tsem/measurement file.  If I understand
> > you correctly, this is basically a series of SHA256 digests without
> > any additional annotations, and without any ordering guarantees,
> > yes?  What is it used for in userspace?
>
> The values in the points file represent the current state of a model,
> they are the coefficients that describe the security events that have
> been modeled.
>
> The output of this file can be captured and written to the
> /sys/fs/tsem/map file in order to define a security model that is to
> be subsequently enforced.

Okay, I was under the assumption that this file was dependent on the
order in which execution takes place on the system, it sounds like
that is not the case and the output of this file is repeatable with a
fairly standard system configuration (e.g. multi-core, multi-user,
etc.).

> > > +What:          /sys/fs/tsem/state
> > > +Date:          November 2022
> > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > +Description:
> > > +               The state file contains the ASCII base 16
> > > +               representation of the 256 bit value of the functional
> > > +               state of a security domain/model.
> > > +
> > > +               The state value is a time independent representation
> > > +               of the measurement of a model/domain, and unlike the
> > > +               measurement value, is a time independent
> > > +               representation of the security state of a workload.
> > > +
> > > +               This value is designed to be a single value that can
> > > +               be attested to represent whether or not a workload ha=
s
> > > +               deviated from a defined security behavior.
>
> > It might be nice to explain how this value is calculated here in
> > this file to remove any time or ordering dependencies.  Once again
> > my apologies if I missed it in the rest of the docs.
>
> The TSEM LSM documentation covers the issues surrounding the
> measurement and state values.  See the section entitled 'Security
> model functional definitions'.

Thanks.  A reference to the related section in the TSEM docs would be
nice to see here.

> Put succinctly, the state value is computed by generating a standard
> linear extension sum over a list of security state points that have
> been sorted in big-endian, ie. natural hash order.
>
> It is designed to provide a time and scheduling independent value that
> can be used to attest that a security model has not violated its
> definition.

Understood.

> Don't apologize, there is a lot there to read, our loquaciousness
> knows no bounds.... :-)
>
> > > +What:          /sys/fs/tsem/trajectory
> > > +Date:          November 2022
> > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > +Description:
> > > +               The trajectory file contains a description of the
> > > +               security events that have occurred in a security
> > > +               domain/model.
> > > +
> > > +               Each entry in this file represents a single security
> > > +               event and consists of brace {} delimited fields that
> > > +               describe the characteristics of a security event.
> > > +               Each field has key=3Dvalue pairs that define
> > > +               characteristics of the field.
> > > +
> > > +               Each line in a trajectory, or forensics, file will
> > > +               always have the event{} and COE{} fields.  The event
> > > +               field describes the characteristics of a security
> > > +               event while the COE field describes the Context Of
> > > +               Execution that is executing the security event.
>
> > I think it would be good to provide a concrete definition of
> > CELL_DEFINITION field as other areas of the documentation make
> > reference to it within the tsem/trajectory file documentation.  We can
> > somewhat infer it's format, fields, etc. but it's much better to be
> > explicit about these things.
>
> Valid point, we will incorporate a broad definition of what the 'CELL'
> represents.
>
> Conceptually, it is equivalent to the 'object' in mandatory access
> controls.  In an events based architecture like TSEM, it is
> essentially the 'bucket' of values that describe the parameters of a
> security event that a COE/process is requesting permission for.

Yes, I understood conceptually what it represents and what data might
be present given a specific operation/rule, but it wasn't clear to me
how that data would be represented in the CELL_DEFINITION.

> > > +               The event{} field consists of the following
> > > +               characteristic definitions:
>
> > I'm unclear as to the purpose of the event{} field as it is neither
> > part of the COE or the CELL, is it here simply to make the event
> > easier to read?  Or am I misunderstanding things and the event{}
> > field is part of the COE?
>
> It actually serves two roles, one of which, as you note, is to make
> the event description easier to read and understand.
>
> It probably comes as no surprise, but the trust orchestration system
> that this is all designed to support, has a security console that can
> be used to review the status of all the trust orchestrators that are
> supervising security workloads.  Either in the cloud, or perhaps, a
> large body of edge devices protecting critical infrastructure, if that
> doesn't give away too much.... :-)
>
> Having the process name and executable easily visualized is fairly
> useful.
>
> The second role is to allow the event description records to be
> self-describing.  The value for the type=3D key is used by the Trusted
> Modeling Agent (TMA) to determine what to look for in the remainder of
> the event description record in order to compute the CELL value.
>
> It also contains the TASK_ID value that ties the security state points
> to the integrity of the executable.  Since that value is a synthetic
> value it was deemed most appropriate to be placed in the event{}
> field.

I think it would be good to provide a more succinct version of the
above in the documentation.

> > > +                       process=3DCOMM
> > > +                               Where COMM is the ASCII representatio=
n
> > > +                               of the name of the process executing
> > > +                               the event.
> > > +
> > > +                       filename=3DPATH
> > > +                               If the CELL definition for an event
> > > +                               references a file the filename
> > > +                               characteristic contains a definition
> > > +                               of the path to the file.
> > > +
> > > +                               In the case where an event does not
> > > +                               have a file the PATH value is set to =
a
> > > +                               value of none.
>
> > What happens in cases where multiple file paths are present in an
> > event?  Also, given this is visible to userspace, and multiple
> > things can affect the path to a file (e.g. namespaces), how is the
> > file path determined?
>
> Unless we have missed something, which is no doubt possible, all of
> the security event hooks that we have implemented, which number about
> 87 now, that act on a 'file', receive only a single 'struct file *'
> pointer as a parameter to the event.
>
> So we haven't encountered a situation where there would be multiple
> files for a single event description.

I haven't seriously looked at the TSEM sources yet, I'm trying to make
sure that I first understand the security model while also ensuring
that it is well documented and reasonable.  While I can't speak to
what LSM hooks TSEM implements, it seems like there are at least a few
operations, rename and link come immediately to mind, which would have
multiple filenames as part of the operation.  How are those operations
handled in TSEM, or are they outside the scope of TSEM?

> There is certainly the case where multiple security state points
> involve the same file.  This can easily be seen, for example, in a
> trust orchestrator running a workload in a runc container, where
> multiple state points are generated by different executable mappings
> of the runc binary at startup
>
> The file path is the absolute pathname in the mount namespace that the
> modeled workload is running in.

I think it is important to specify that the path recorded here is in
the context of the mount namespace of the task generating the event.
Yes, one could reasonably assume that, given the disjoint nature of
mount namespaces, but with several other fields being recorded in the
context of the initial namespace I think it is important to note these
differences.

> > > +                       type=3DEVENT_TYPE
> > > +                               The value field for a type key is the
> > > +                               name of the security event that is
> > > +                               being modeled.  The list of value
> > > +                               EVENT_TYPE names is defined in the
> > > +                               following source file:
> > > +
> > > +                               security/tsem/tsem.c
> > > +
> > > +                               If the security event is a genericall=
y
> > > +                               modeled event the EVENT_TYPE will be
> > > +                               generic_event.  In this case the CELL
> > > +                               characteristics for the event will be
> > > +                               described by a generic_event{} field.
> > > +
> > > +                       task_id=3DTASK_ID
> > > +                               The value of the task_id key will the
> > > +                               ASCII base 16 representation of the
> > > +                               model identity of the task that is
> > > +                               executing the security event.
> > > +
> > > +                               The following documentation file:
> > > +
> > > +                               Documentation/admin-guide/LSM/TSEM.rs=
t
> > > +
> > > +                               Describes how the TASK_ID value is
> > > +                               generated.
> > > +
> > > +               The COE{} field consists of the following
> > > +               characteristic definitions:
> > > +
> > > +                       uid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the discretionar=
y
> > > +                               user id of the process that is
> > > +                               executing the security event.
>
> > Given the ability to map UID/GID values in the kernel, what will be
> > used as the basis for the COE?  What happens when the basis used in
> > the kernel's COE generation does not match the basis used by the
> > external modeler?
>
> The UID/GID values used are the values defined in the initial
> user namespace, see security/tsem/event.c:get_COE().

Once again, please note that in the documents.

> The basis set state that the trust orchestrator is running in has no
> effect on the generation of the security state point.  The modeling
> engine only operates on the values presented to it and determines if
> the state point generated from the state description matches the model
> it has been requested to enforce.
>
> If it doesn't, the event is considered to violate the trust model.
>
> > > +                       euid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the effective
> > > +                               discretionary user id of the process
> > > +                               that is executing the security event.
> > > +
> > > +                       euid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the effective
> > > +                               discretionary user id of the process
> > > +                               that is executing the security event.
> > > +
> > > +                       suid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the saved user i=
d
> > > +                               of the process that is executing the
> > > +                               security event.
> > > +
> > > +                       gid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the discretionar=
y
> > > +                               group id of the process that is
> > > +                               executing the security event.
> > > +
> > > +                       egid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the discretionar=
y
> > > +                               effective group id of the process tha=
t
> > > +                               is executing the security event.
> > > +
> > > +                       egid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the discretionar=
y
> > > +                               effective group id of the process tha=
t
> > > +                               is executing the security event.
> > > +
> > > +                       sgid=3DNN
> > > +                               The base 10 ASCII representation of
> > > +                               the numeric value of the saved
> > > +                               discretionary group id of the process
> > > +                               that is executing the security event.
> > > +
> > > +                       fsuid=3DNN
> > > +                               The base 10 ASCII representation of
> > > +                               the numeric value of the discretionar=
y
> > > +                               filesystem user id of the process tha=
t
> > > +                               is executing the security event.
> > > +
> > > +                       fsgid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the numeric value of the discretionar=
y
> > > +                               filesystem group id of the process
> > > +                               that is executing the security event.
> > > +
> > > +                       cap=3D0xNNN
> > > +                               The ASCII base 16 representation of
> > > +                               the numeric value of effective
> > > +                               capabilities of the process that is
> > > +                               executing the security event.
> > > +
> > > +               If the CELL value for a security event includes the
> > > +               definition of a file a file{} event field will be
> > > +               included.  The following characteristics will be
> > > +               encoded in this field:
> > > +
> > > +                       flags=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the flags value of the 'struct file'
> > > +                               structure that is the source of the
> > > +                               file description.
> > > +
> > > +                       uid=3DNN
> > > +                               The ASCII base 10 representation of
> > > +                               the discretionary user id of the file=
.
> > > +
> > > +                       gid=3DNN
> > > +                               The base 10 ASCII representation of
> > > +                               the discretionary group id of the
> > > +                               file.
>
> > Similar to the task UID/GID mapping questions above, there are
> > mechanisms which map the file user/group IDs, which will be used in
> > the CELL definition and how will that be resolved between the kernel
> > and an external modeler?
>
> The answer is the same as with the COE, see the following function:
>
> security/tsem/event.c:get_file_cell()
>
> Once again, the TMA only operates on the event description presented
> to it and is not influenced by its own namespace.

For this particular point, my concern isn't what policy the TMA
implements, or what it uses as input, it's about understanding how
this event information is collected.  For fields which can be
namespaced (I'm referring to "normal" Linux Kernel namespaces and not
any TSEM namespaces), the TSEM documentation should make it clear
which namespace is used as a basis for the value.

> > > +What:          /sys/fs/tsem/ExternalTMA
> > > +Date:          November 2022
> > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > +Description:
> > > +               The ExternalTMA directory is a container directory
> > > +               that hold files that will be used to export the
> > > +               security events, and their associated parameters, for
> > > +               externally modeled security domains/namespaces.
> > > +
> > > +               The files created in this directory will be named by
> > > +               the base 10 ASCII representation of the id value
> > > +               assigned to the modeling domain/namespace.  See the
> > > +               documentation for the /sys/fs/tsem/id file in this
> > > +               documentation for more details on this value.
> > > +
> > > +               This file will is a read-only file that can be polled
> > > +               by a userspace trust orchestration implementation to
> > > +               process security events that are to be modeled by
> > > +               an external Trusted Modeling Agent.
> > > +
> > > +               The type of the exported event is the first keyword o=
f
> > > +               the line that is output and have the following
> > > +               values and arguments:
> > > +
> > > +               aggregate HEXID:
> > > +                       Where HEXID is the ASCII base 16
> > > +                       representation of the 256 bit hardware
> > > +                       platform aggregate value.
> > > +
> > > +               export pid{NNN} COE{} CELL_DEFINITION
> > > +                       Where the NNN in the pid field is the ASCII
> > > +                       base 10 value of the id of the process that i=
s
> > > +                       executing the security event that will be
> > > +                       modeled.
>
> > I worry whenever I see a PID used as an identifier shared across the
> > kernel/userspace boundary as it is inherently racy.  Given the
> > somewhat coarse COE definition where one can expect multiple
> > processes/PIDs to share the same COE value, and the ability of
> > untrusted users/processes to manipulate the PID table, what do you
> > expect to use the pid{NNN} field for in this event?
> >
> > Similar to the other namespace/mapping issues discussed previously,
> > there is also the PID namespace issue to worry about.  How is that
> > handled here?
>
> The concern over the PID issue is understandable, I will treat the
> reasoning behind its use below.
>
> The PID value is the 'native' value managed by the kernel, not a
> mapped value.

Regardless of if the PID is rooted in the initial namespace or a
different PID namespace, the issue of PIDs being inherently racy is a
real problem.  Can you help me understand how TSEM avoids the common
pitfalls associated with using PIDs to identify processes on the
system?

> > > +                       The COE field has the same format as the fiel=
d
> > > +                       emitted for a trajectory or forensics event.
> > > +
> > > +                       The CELL_DEFINITION are the same field
> > > +                       definitions that are emitted for a trajectory
> > > +                       or forensics event.
> > > +
> > > +               log process{name} event{type} action{type}
> > > +                       The log event is emitted when an untrusted
> > > +                       task attempts to execute a security event.
> > > +
> > > +                       The name value of the COE field is the name o=
f
> > > +                       the process (comm value) that is executing th=
e
> > > +                       security event.
> > > +
> > > +                       The type value of the event field is the name
> > > +                       of the security event being executed as
> > > +                       defined in the tsem_names array in the
> > > +                       security/tsem/tsem.c file.
> > > +
> > > +                       The type value of the action field is the typ=
e
> > > +                       of action the LSM enforced in response to
> > > +                       encountering the untrusted process.  This
> > > +                       value will be either LOG or EPERM to represen=
t
> > > +                       whether or not the trust violation is being
> > > +                       logged or enforced.
> > > +
> > > +What:          /sys/fs/tsem/control
> > > +Date:          November 2022
> > > +Contact:       Greg Wettstein <greg@enjellic.com>
> > > +Description:
> > > +               The control file is the only writable file in the
> > > +               filesystem and is used by the trust orchestrators to
> > > +               configure and control the behavior of the TSEM
> > > +               implementation.
> > > +
> > > +               The following keyword and arguments are recognized:
> > > +
> > > +               internal:
> > > +                       The internal keyword causes an internally
> > > +                       modeled domain to be created for the calling
> > > +                       process.
> > > +
> > > +               external:
> > > +                       The external keyword causes an externally
> > > +                       modeled domain to be created for the calling
> > > +                       process.
> > > +
> > > +               enforce:
> > > +                       The enforce keyword causes the modeling
> > > +                       domain/namespace of the process to enter
> > > +                       enforcing mode.  In this mode a value of
> > > +                       -EPERM will be returned for a security event
> > > +                       that does not map into the current set of
> > > +                       allowed state points for the security model
> > > +                       being implemented for the domain/namespace.
> > > +
> > > +               seal:
> > > +                       The seal keyword causes the security model
> > > +                       being implemented for the model to be placed
> > > +                       in sealed state.  In this state the current
> > > +                       set of security event points is considered to
> > > +                       be the only set of valid points for the
> > > +                       domain/model.  Any subsequent events that map
> > > +                       to a point not in the current model will be
> > > +                       considered a violation of the model.
> > > +
> > > +               trusted PID:
> > > +                       The trusted keyword is used by a trust
> > > +                       orchestrator to indicate that the process
> > > +                       identified by the PID argument should be
> > > +                       allowed to run in trusted status.
> > > +
> > > +               untrusted PID:
> > > +                       The untrusted keyword is used by a trust
> > > +                       orchestrator to indicate that the process
> > > +                       identified by the PID argument should be
> > > +                       allowed to run but designated as an untrusted
> > > +                       process.
>
> > The 'trusted PID:' and 'untrusted PID:' commands are concerning for
> > the reasons described above about PIDs being racy and generally an
> > unreliable way of identifying processes across the kernel/userspace
> > boundary.  I suspect it would not be too difficult for a malicious
> > user to trick an external modeler into marking the wrong process as
> > trusted/untrusted.
>
> An external TMA needs the PID value to determine which process to wake
> up and set the trust status value on in the task control structure,
> after the event is modeled.  As was noted above, the PID value is the
> unmapped value maintained by the OS.
>
> Lets see if we can reason through why the PID can be used safely.
>
> CAP_TRUST, or whatever ends up getting used, is required by the trust
> orchestrator to create a security/modeling namespace for the workload
> being modeled.  This results in the creation of the following
> pseudo-file for surfacing the security event descriptions for the
> namespace/workload:
>
> /sys/fs/tsem/ExternalTMA/N
>
> Where N is the id number of the modeling domain.
>
> CAP_TRUST, caveats applied, is required to open the pseudo-file.  The
> trust orchestrator only receives and acts on PID values through this
> conduit from the kernel.
>
> When an event description is exported, the trust status of the task is
> set to 'pending' and the process is placed in interruptible sleep and
> scheduled away, with the 'wakeup' criteria being the trust status
> being changed from pending to either trusted or untrusted.
>
> The only path to change the trust status value in the LSM task control
> structure and wake up the process is by the trust orchestrator that
> created the namespace, by writing the appropriate value to the
> /sys/fs/tsem/control file.  Access to that file is gated by CAP_TRUST
> or its equivalent.
>
> See the following code locations for further details:
>
> security/tsem/export.c:tsem_export_event()
>
> security/tsem/fs.c:control_COE()
>
> As long as the process 'exists', albeit sleeping, the PID slot is
> occupied and an adversary, regardless of namespace, cannot substitute
> a task with the same PID value.
>
> This leaves an adversary with the need to terminate the task being
> modeled in order to capture its PID slot.
>
> Precautions are implemented in the following function to protect the
> process from being terminated by an adversary:
>
> security/tsem/tsem.c:tsem_task_kill()

What about the OOM killer?

The security_task_kill() LSM hook only offers an access control point
for one process sending another process a signal, it doesn't gate a
process being killed for other reasons.  The OOM killer is the first
thing that comes to mind, but I'm reasonably certain there are other
similar scenarios.

> > > +               state HEXID:
> > > +                       The state keyword is used to indicate that th=
e
> > > +                       security state point identified by the ASCII
> > > +                       base 16 encoded value should be loaded into
> > > +                       the current security model as a valid securit=
y
> > > +                       event state.
> > > +
> > > +               pseudonym HEXID
> > > +                       The pseudonym keyword is used to indicate tha=
t
> > > +                       the pathname, identified by the 256 bit ASCII
> > > +                       base 16 encoded value HEXID, should be
> > > +                       designated to return a constant digest value
> > > +                       for the contents of the file.
> > > +
> > > +                       The HEXID value is computed with the followin=
g
> > > +                       function:
> > > +
> > > +                       HEXID =3D SHA256(PATHNAME_LENGTH || PATHNAME)
>
> > This seems like an unusual design choice, and perhaps one born from
> > necessity ... ?  It's nice that it is opt-in, but I would be curious
> > to hear what problems this solved.
>
> It is an approximation method that allows things like log files and
> .bash_history files to be effectively modeled.

Okay, that's what I suspected, I just wanted to make sure there wasn't
something else I was missing.

> > > +               base HEXID
> > > +                       The base keyword is used to indicate that the
> > > +                       256 bit ASCII base 16 encoded value HEXID
> > > +                       should be registered as the value used to
> > > +                       generate model specific security event points=
.
> > > +
> > > +                       A model specific base value is designed to be
> > > +                       used as a 'freshness' nonce, similar to an
> > > +                       attestation nonce, to prove that a model stat=
e
> > > +                       value or measurement is current and not being
> > > +                       replayed.
> > > diff --git a/Documentation/admin-guide/LSM/tsem.rst b/Documentation/a=
dmin-guide/LSM/tsem.rst
> > > new file mode 100644
> > > index 000000000000..f03e5269cd25
> > > --- /dev/null
> > > +++ b/Documentation/admin-guide/LSM/tsem.rst
> > > @@ -0,0 +1,1240 @@
> > > +=3D=3D=3D=3D
> > > +TSEM
> > > +=3D=3D=3D=3D
> >
> > ...
> >
> > > +Process and Platform Trust Status
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +A fundamental concept in TSEM is the notion of providing a precise
> > > +definition for what it means for a platform or workload to be truste=
d.
> > > +A trusted platform or workload is one where there has not been an
> > > +attempt by a process to execute a security relevant event that does
> > > +not map into a known security state point.
> > > +
> > > +The process trust status is a characteristic of the process that is
> > > +passed to any subordinate processes that are descendants of that
> > > +process.  Once a process is tagged as untrusted, that characteristic
> > > +cannot be removed from the process.  In a 'fruit from the poisoned
> > > +vine' paradigm, all subordinate processes created by an untrusted
> > > +process are untrusted as well.
> > > +
> > > +On entry into each TSEM security event handler, the trust status of =
a
> > > +process is checked before an attempt to model the event is made.  An
> > > +attempt to execute a security event by an untrusted process will cau=
se
> > > +the event, and its characteristics, to be logged.  The return status
> > > +of the hook will be determined by the enforcement state of the model=
.
> > > +A permission denial is only returned if the TMA is running in
> > > +enforcing mode.
> > > +
> > > +If the platform running the TSEM LSM has a TPM, the hardware aggrega=
te
> > > +value is computed at the time that TSEM is initialized.  This hardwa=
re
> > > +aggregate value is the linear extension sum over Platform
> > > +Configuration Registers (PCR's) 0 through 7.  This is the same
> > > +aggregate value that is computed by the Integrity Measurement
> > > +Architecture (IMA) and is the industry standard method of providing =
an
> > > +evaluation measurement of the hardware platform state.
> > > +
> > > +Internally model domains have the hardware aggregate measurement
> > > +included as the first state point in the security model.  Externally
> > > +modeled domains export the hardware aggregate value to the TMA for
> > > +inclusion as the first state point of the model maintained by the TM=
A.
> > > +
> > > +The root modeling domain extends each security state point into PCR
> > > +11.  This allows hardware based TSEM measurements to coexist with IM=
A
> > > +measurement values.  This hardware measurement value can be used to
> > > +attest to the security execution trajectory that the root model
> > > +maintains.
>
> > It seems like making the target PCR configurable would be a good
> > idea, at the very least make it a Kconfig option.
>
> That was something that we have thought about, it probably needs a
> Kconfig option.
>
> Contrary to all appearances, as a team we are really minimalists at
> heart and tend to not make things more complex or configurable than
> needed.... :-)
>
> > Also, can you elaborate on how the security state points are
> > extended into the PCR?  I imagine for it to be useful at an
> > arbitrary point in time this would require the PCR to be extended as
> > the security points were generated, which would imply that the PCR
> > value would be dependent on execution order, and in most cases,
> > scheduling order as well.  How useful do you expect this to be for
> > most users?
>
> Your assessment is correct, the state points are extended into the PCR
> whenever a unique security state point is generated.
>
> In a 'free-running' model, the value in the register will be fungible
> due to scheduling dependencies.

In other words, garbage ;)

> If the model is pre-defined, the security state points will be
> extended into the register as they are loaded through the
> /sys/fs/tsem/map pseudo-file interface.  In this case, the value will
> be fixed and any departure from the value would signal that the
> modeling domain has departed from its specification.
>
> With respect to the utility of the value, in a 'free-running' model it
> is about as useful as the value that IMA maintains in PCR 10, which in
> our opinion is not very useful and is why we implemented the notion of
> the 'state' value of a model.

For a variety of reasons, and mostly to help keep things civil, let's
refrain from comparing one LSM to another.  Each LSM makes its own
choices, and needs to stand on its own; just because LSM did X doesn't
mean TSEM can do X if it is silly in the context of TSEM.

> The primary utility of the value is that it is a hardware maintained
> reference value that can be used to confirm the set of measurements
> committed to the register.

Given that the PCR value is only deterministic in the case of a
predefined policy/model, it seems like it would be worth stating that
a bit more clearly in the docs.

> So our 'state' value gives us a constant 'good' value for the security
> model.  The PCR 11 value provides a hardware root of trust for the set
> of points that lead to the state value.

Just to make sure I understand you, in the predefined case PCR 11 is
extended with the SRTM PCRs as well as a measurement of the TSEM
policy at load time, yes?

> > > +Internal vs external modeling
> > > +-----------------------------
> > > +
> > > +When a TSEM modeling domain is created, a designation is made as to
> > > +whether the domain is to be internally or externally modeled.
> > > +
> > > +In an internally modeled domain, the security event handlers pass th=
e
> > > +event type and its characteristics to the designated internal truste=
d
> > > +modeling agent.  The agent provides the permission value for the
> > > +security event handler to return as the result of the event and sets
> > > +the trust status of the process executing the event.
> > > +
> > > +In an externally modeled domain, the event type and parameters are
> > > +exported to userspace for processing by a trust orchestrator with an
> > > +associated TMA.  The trust orchestrator communicates the result of t=
he
> > > +modeling back to the kernel to support the setting of the process
> > > +trust status.
> > > +
> > > +This model poses a limitation to the ability of TSEM to model some
> > > +security events.  This is secondary to the fact that some event
> > > +handlers (LSM hooks) are called from a non-sleeping context, as a
> > > +result the process cannot be scheduled.  This is particularly the ca=
se
> > > +with the task based hooks, since they are typically called with the
> > > +tasklist lock held.
> > > +
> > > +This limitation is also inherent to the root model that extends the
> > > +security state points into TPM PCR 11, secondary to the fact that th=
e
> > > +process invoking the security event hook will be scheduled away whil=
e
> > > +the TPM transaction completes.
> > > +
> > > +Addressing this problem directly requires a consideration of the
> > > +context from which the security event handlers are being called.
> > > +Subsequent implementations of TSEM will include a mechanism for
> > > +asynchronous deferral of model processing, until when and if, a revi=
ew
> > > +of the call context would be considered worthwhile by the LSM
> > > +community.
>
> > This is a pretty big limitation, and in conjunction with the some of
> > the other issues brought up earlier (the PID issue seems the most
> > concerning), I'm having a difficult time believeing that an external
> > modeler could operate safely given the design presented here.
>
> With respect to the PID issue, we would welcome any comments on the
> analysis that we provided above as to its design safety.

From what I can tell from the documentation and our discussion thus
far is that TSEM relies on a security_task_kill() hook implementation
to ensure that a process is not killed, and the PID released, without
explicit TSEM approval.  Unfortunately, I believe that relying solely
on security_task_kill() will not fully cover all of the cases where a
process can be killed, mostly because security_task_kill() does not
control process destruction, it controls the ability of one process to
signal another.

You might be able to do something with security_task_free(), but I
haven't given that much thought.

> If the PID issue remains a concern, we have an extension to the export
> descriptions that would include a random nonce that would be emitted
> with the PID.  The nonce would be placed in the LSM task control
> 'blob' for the sleeping task and used to confirm that the task release
> directive was acting on the correct process.

That should help, but ultimately a nonce is still a bounded resource
and subject to recycling just like the PID.  I'm open to hearing other
ways in which you believe you can resolve this issue, but I remain
skeptical.

> > Unfortunately, there will always be LSM hooks which need to operate
> > in a non-blocking context, meaning this challenge is here to stay.
> > Help me understand how you could safely do asynchronous policy
> > enforcement with an external modeler, I'm not sure it's possible.
>
> Electing to implement asynchronous enforcement would require further
> thought.  We were operating in the context of full disclosure in our
> documentation and wanted to be up front about limitations and options.
>
> To be clear, at this time, we are not advocating for or bringing
> forward an asynchronous update architecture.
>
> So, at this time, there is a well understood modeling limitation with
> respect to the LSM hook implementations.  That limitation is not
> limited to external TMA's, since the event state points cannot be
> extended into a TPM in a non-blocking context.

I think these limitations need to be made explicit in the
documentation.  If the TSEM security model can not be faithfully
implemented, the documented security model may need to change.

> > Frankly, I also wonder how a system would perform with an external
> > modeler, indepdent of the issues with non-blocking hooks.  How does
> > the system perform with every blockable LSM hook invocation
> > potentially blocking on a response from userspace?  Or with the COE
> > being somewhat coarse, does the trajectory/policy populate itself
> > quickly?
>
> One obviously experiences a latency hit in going to userspace, by
> definition, implementing security always has an associated resource
> cost.  So, once again, this comes down to a cost/benefit analysis.
>
> As a Gedanken exercise, consider the value proposition of a Linux
> based RTU, or other device, controlling infrastructure that can only
> execute security relevant events that are guaranteed to be known good
> by an external co-processor that is only accessible as a security
> oracle.
>
> Given that frame of reference.
>
> Time for a userspace or SGX based TMA transaction is running around
> 890 micro-seconds.
>
> Going to a TMA based in a Xen stubdomain implementation runs a bit
> longer, probably around 940 micro-seconds or so.
>
> The micro-controller implementations are decidedly slower, with the
> NRF52840-DONGLE clocking in at around 40 micro-seconds, but that is
> strictly a CPU horsepower issue.
>
> All of this with the caveat that we have been focusing almost
> exclusively on correctness and not optimizing performance.
>
> We've thought a bit, mainly on long walks with our Golden Retriever
> Izzy, about the issue of building a kernel based policy cache with
> externally modeled domains.  Given that the kernel does not, a-priori,
> know what modeling algorithm a TMA might be using, we would need to
> come up with a method of deterministically mapping a security event
> description to a known good state point value.
>
> The other issue with all this is that with containerized workloads,
> particularly micro-services, the rate of security event generation can
> be surprisingly low.  Obviously this is also the case with embedded
> implementations.
>
> Once again, what are you willing to pay to be safe?

For better or worse, when code is proposed for the upstream Linux
Kernel it is subject to scrutiny from all manner of developers and
users, with most being focused on their own pet projects/subsystems,
not whatever new security promises you are providing.

There have been patch(sets) and discussions relating to performance
gains/losses on the other of tens of nanoseconds per operation.

I think most of us in the security community are sympathetic to the
question of "what are you willing to pay to be safe", but please
understand that while we are understanding, there are others who will
disagree not only with the performance cost tradeoff, but the very
idea of safety you are promising.  My only suggestion is to be
prepared, and be honest with the performance assessments of TSEM.

> > > +Event handlers that cannot be directly modeled, still consider, on
> > > +entry, whether or not they are being called by an trusted or untrust=
ed
> > > +process.  As a result, an untrusted process will cause a non-modeled
> > > +event to return a permissions violation in enforcing mode, even if t=
he
> > > +security event cannot be directly modeled.
> > > +
> > > +Security event modeling typically traps violations of trust by a COE
> > > +with unmodeled characteristics that is attempting to access/execute =
a
> > > +file or map memory as executable; or by a COE with known
> > > +characteristics attempting to access or execute a CELL not prescribe=
d
> > > +by a model.  As a result, the impact of the ability to not directly
> > > +model these events is lessened.
> >
> > ...
> >
> > > +Event modeling
> > > +--------------
> > > +
> > > +TSEM security event modeling is based on the following functional
> > > +definition for a security state point:
> > > +
> > > +Sp =3D SHA256(SHA256(EVENT_ID) || TASK_ID || SHA256(COE) || SHA256(C=
ELL))
>
> > It appears that all of the hasing in TSEM is SHA256 based, you might
> > want to consider making that a Kconfig option at the very least.
>
> That has been something that we have talked about as well.
>
> As I indicated previously, we really are minimalists, particularly
> after watching IMA fight with issues surrounding algorithmic agility.
>
> It would be easy enough to make this configurable but does anyone see
> SHA256 as not being useful in in this role anywhere in the next 10
> years?

There are any number of reasons why one might need to select a
different hash algorithm: legal constraints, security certifications,
corporate policy.  I would strongly suggest making this configurable.

--=20
paul-moore.com
