Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D4C636D7
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Feb 2023 04:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBMEdn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Feb 2023 23:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBMEdl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Feb 2023 23:33:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0386EB76C
        for <linux-security-module@vger.kernel.org>; Sun, 12 Feb 2023 20:33:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be8so12266078plb.7
        for <linux-security-module@vger.kernel.org>; Sun, 12 Feb 2023 20:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDNRcmea4ASdE1K6x62LRrfr4QcBsM5FAql2TFkSkFc=;
        b=bWxXsKe3P9sJi59ZXKA0ZF2aS2UicBsuWtseR0tgIxFIZ2BUcq+YNO05EvUE73yTwH
         7HxRbqma8siWpHNNJ5CkZg0WzIT0pIN7qPfAZl2BwNffQ1SXMpVPzgsxW4vJ4D1Cjc9w
         0j+e6I98yBD/RB7F/xDkfvLDrOVOfiVNeFeDOCSPFgohbnNYVpStyMg8ZbuuVYCwCQOX
         D5GZrLKg3k8NnSR2PhRnIHZKqVngT/4ADQPg7/yRMvwwxINfl6jZeGmCiVdsfEuEw/Nj
         /3HmgiSmxwcy9PkTP7ERHK9pnpQGSbg30vQIAVUT6DTVcmNbtSaDrLirnKleNNok37oU
         1CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDNRcmea4ASdE1K6x62LRrfr4QcBsM5FAql2TFkSkFc=;
        b=tkw6AMvEnUqJWiItC8lfi8i2kU5balkADF1t9SSt2vzGhLtZvKjtG91zmIpgumKDDi
         5zUgmtKJ7BGy+/Hu0v3WZG8Yud+GbpNVKxiSuVqVuwe5dkOpAvJYJEV4i+Eg4axz/idk
         9YPYPAi4rpgvOev+PsBKLQwZK9Xv0IPQUGs1k5imP4XVJplsuv5cfqHJtArF7ddxMJFb
         uIHe4jMgiYxzuwcUQRqEHDtJKiam3DEikGabyN+3k54j9ieaaFSvVG9Zf1zTy2FuLyR2
         in4YtLRBAAFk2edMvUpgY1e6ibtS6XGQlz+T8h/7j2QHTEZZotcNJEtEQpXOuR8llRK0
         RoeA==
X-Gm-Message-State: AO0yUKX5pA/0NIVlzwq/KzJ5QZyDoMCsF5f0XtXglmI9dcXCxNlBjfYG
        1im1trXZo3frMu+WAdN1bLbaWEtUahUWH6rUzixL3yAgn+tCTZI=
X-Google-Smtp-Source: AK7set/nMIVs7wokt/u2URvIIoHYCPXmWNCDiwjOlWJsxcwF2+z2GsTI5jFMsjxHKk7kl2E0ZDfqx4YlEU5rgL2nKO0=
X-Received: by 2002:a17:902:ab4e:b0:19a:819d:8770 with SMTP id
 ij14-20020a170902ab4e00b0019a819d8770mr1325602plb.35.1676262817942; Sun, 12
 Feb 2023 20:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20230204050954.11583-1-greg@enjellic.com> <20230204050954.11583-3-greg@enjellic.com>
In-Reply-To: <20230204050954.11583-3-greg@enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Feb 2023 23:33:26 -0500
Message-ID: <CAHC9VhQnZhczVRifSnM-zv46Cb9OFuh=6ha+1zKJaOUK15=K5A@mail.gmail.com>
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Feb 4, 2023 at 12:33 AM Dr. Greg <greg@enjellic.com> wrote:
>
> An entry was added to the ABI testing documentation to document
> the files in the TSEM management filesystem.
>
> The file documenting the kernel command-line parameters was
> updated to document the tsem_mode command-line parameter.
>
> The primary TSEM documentation file was added to the LSM
> administration guide and the file was linked to the index of LSM
> documentation.
>
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  Documentation/ABI/testing/tsemfs              |  576 ++++++++
>  Documentation/admin-guide/LSM/index.rst       |    1 +
>  Documentation/admin-guide/LSM/tsem.rst        | 1240 +++++++++++++++++
>  .../admin-guide/kernel-parameters.txt         |    5 +
>  4 files changed, 1822 insertions(+)
>  create mode 100644 Documentation/ABI/testing/tsemfs
>  create mode 100644 Documentation/admin-guide/LSM/tsem.rst

One of the more important requirements for any new LSM is that it
documents a clear, understandable, and reasonable security model along
with an implementation that faithfully implements that model.  Before
I looked at your code I wanted to try and understand the TSEM security
model and a few things jumped out at me rather quickly, I imagine
there would be others as I start to look a bit closer but I wanted to
send these questions/comments along now to get your take on them ...

> diff --git a/Documentation/ABI/testing/tsemfs b/Documentation/ABI/testing/tsemfs
> new file mode 100644
> index 000000000000..3d326934624c
> --- /dev/null
> +++ b/Documentation/ABI/testing/tsemfs
> @@ -0,0 +1,576 @@

...

> +What:          /sys/fs/tsem/aggregate
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The aggregate file contains the ASCII base 16
> +               representation of the 256 bit hardware platform
> +               aggregate that TSEM is modeling under.  The platform
> +               aggregate is the extension measurement of the Trusted
> +               Platform Module PCR registers 0 through 8.

I'm guessing the above is a typo and you mean PCRs 0 through 7 (not
8)?  If not, you need to provide an explanation somewhere as to what
you are using PCR 8 for in TSEM and how it is extended, etc.

> +What:          /sys/fs/tsem/measurement
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The measurement file contains the ASCII base 16
> +               hexadecimal representation of the 256 bit measurement
> +               value of the security model that the process is
> +               operating in.
> +
> +               The measurement value is the classic linear extension
> +               measurement of the model.  An updated measurement
> +               value is created by extending the current measurement
> +               value with the state coefficient computed for a
> +               security event.
> +
> +               This measurement value represents a time dependent
> +               measurement of a model and is susceptible to
> +               deviations caused by scheduling differences between
> +               subsequent invocations of a workload.

Given the very volatile nature of this value, what is it used for in
userspace?  My apologies if I missed it in the docs.

> +What:          /sys/fs/tsem/points
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The points file contains the ASCII base 16
> +               representation of the 256 bit security state points of
> +               a security domain/model.  The number of entries in
> +               this file represent the number of security events that
> +               are represented by the model.

A similar questions to the tsem/measurement file.  If I understand you
correctly, this is basically a series of SHA256 digests without any
additional annotations, and without any ordering guarantees, yes?
What is it used for in userspace?

> +What:          /sys/fs/tsem/state
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The state file contains the ASCII base 16
> +               representation of the 256 bit value of the functional
> +               state of a security domain/model.
> +
> +               The state value is a time independent representation
> +               of the measurement of a model/domain, and unlike the
> +               measurement value, is a time independent
> +               representation of the security state of a workload.
> +
> +               This value is designed to be a single value that can
> +               be attested to represent whether or not a workload has
> +               deviated from a defined security behavior.

It might be nice to explain how this value is calculated here in this
file to remove any time or ordering dependencies.  Once again my
apologies if I missed it in the rest of the docs.

> +What:          /sys/fs/tsem/trajectory
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The trajectory file contains a description of the
> +               security events that have occurred in a security
> +               domain/model.
> +
> +               Each entry in this file represents a single security
> +               event and consists of brace {} delimited fields that
> +               describe the characteristics of a security event.
> +               Each field has key=value pairs that define
> +               characteristics of the field.
> +
> +               Each line in a trajectory, or forensics, file will
> +               always have the event{} and COE{} fields.  The event
> +               field describes the characteristics of a security
> +               event while the COE field describes the Context Of
> +               Execution that is executing the security event.

I think it would be good to provide a concrete definition of
CELL_DEFINITION field as other areas of the documentation make
reference to it within the tsem/trajectory file documentation.  We can
somewhat infer it's format, fields, etc. but it's much better to be
explicit about these things.

> +               The event{} field consists of the following
> +               characteristic definitions:

I'm unclear as to the purpose of the event{} field as it is neither
part of the COE or the CELL, is it here simply to make the event
easier to read?  Or am I misunderstanding things and the event{} field
is part of the COE?

> +                       process=COMM
> +                               Where COMM is the ASCII representation
> +                               of the name of the process executing
> +                               the event.
> +
> +                       filename=PATH
> +                               If the CELL definition for an event
> +                               references a file the filename
> +                               characteristic contains a definition
> +                               of the path to the file.
> +
> +                               In the case where an event does not
> +                               have a file the PATH value is set to a
> +                               value of none.

What happens in cases where multiple file paths are present in an
event?  Also, given this is visible to userspace, and multiple things
can affect the path to a file (e.g. namespaces), how is the file path
determined?

> +                       type=EVENT_TYPE
> +                               The value field for a type key is the
> +                               name of the security event that is
> +                               being modeled.  The list of value
> +                               EVENT_TYPE names is defined in the
> +                               following source file:
> +
> +                               security/tsem/tsem.c
> +
> +                               If the security event is a generically
> +                               modeled event the EVENT_TYPE will be
> +                               generic_event.  In this case the CELL
> +                               characteristics for the event will be
> +                               described by a generic_event{} field.
> +
> +                       task_id=TASK_ID
> +                               The value of the task_id key will the
> +                               ASCII base 16 representation of the
> +                               model identity of the task that is
> +                               executing the security event.
> +
> +                               The following documentation file:
> +
> +                               Documentation/admin-guide/LSM/TSEM.rst
> +
> +                               Describes how the TASK_ID value is
> +                               generated.
> +
> +               The COE{} field consists of the following
> +               characteristic definitions:
> +
> +                       uid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the discretionary
> +                               user id of the process that is
> +                               executing the security event.

Given the ability to map UID/GID values in the kernel, what will be
used as the basis for the COE?  What happens when the basis used in
the kernel's COE generation does not match the basis used by the
external modeler?

> +                       euid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the effective
> +                               discretionary user id of the process
> +                               that is executing the security event.
> +
> +                       euid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the effective
> +                               discretionary user id of the process
> +                               that is executing the security event.
> +
> +                       suid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the saved user id
> +                               of the process that is executing the
> +                               security event.
> +
> +                       gid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the discretionary
> +                               group id of the process that is
> +                               executing the security event.
> +
> +                       egid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the discretionary
> +                               effective group id of the process that
> +                               is executing the security event.
> +
> +                       egid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the discretionary
> +                               effective group id of the process that
> +                               is executing the security event.
> +
> +                       sgid=NN
> +                               The base 10 ASCII representation of
> +                               the numeric value of the saved
> +                               discretionary group id of the process
> +                               that is executing the security event.
> +
> +                       fsuid=NN
> +                               The base 10 ASCII representation of
> +                               the numeric value of the discretionary
> +                               filesystem user id of the process that
> +                               is executing the security event.
> +
> +                       fsgid=NN
> +                               The ASCII base 10 representation of
> +                               the numeric value of the discretionary
> +                               filesystem group id of the process
> +                               that is executing the security event.
> +
> +                       cap=0xNNN
> +                               The ASCII base 16 representation of
> +                               the numeric value of effective
> +                               capabilities of the process that is
> +                               executing the security event.
> +
> +               If the CELL value for a security event includes the
> +               definition of a file a file{} event field will be
> +               included.  The following characteristics will be
> +               encoded in this field:
> +
> +                       flags=NN
> +                               The ASCII base 10 representation of
> +                               the flags value of the 'struct file'
> +                               structure that is the source of the
> +                               file description.
> +
> +                       uid=NN
> +                               The ASCII base 10 representation of
> +                               the discretionary user id of the file.
> +
> +                       gid=NN
> +                               The base 10 ASCII representation of
> +                               the discretionary group id of the
> +                               file.

Similar to the task UID/GID mapping questions above, there are
mechanisms which map the file user/group IDs, which will be used in
the CELL definition and how will that be resolved between the kernel
and an external modeler?

> +What:          /sys/fs/tsem/ExternalTMA
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The ExternalTMA directory is a container directory
> +               that hold files that will be used to export the
> +               security events, and their associated parameters, for
> +               externally modeled security domains/namespaces.
> +
> +               The files created in this directory will be named by
> +               the base 10 ASCII representation of the id value
> +               assigned to the modeling domain/namespace.  See the
> +               documentation for the /sys/fs/tsem/id file in this
> +               documentation for more details on this value.
> +
> +               This file will is a read-only file that can be polled
> +               by a userspace trust orchestration implementation to
> +               process security events that are to be modeled by
> +               an external Trusted Modeling Agent.
> +
> +               The type of the exported event is the first keyword of
> +               the line that is output and have the following
> +               values and arguments:
> +
> +               aggregate HEXID:
> +                       Where HEXID is the ASCII base 16
> +                       representation of the 256 bit hardware
> +                       platform aggregate value.
> +
> +               export pid{NNN} COE{} CELL_DEFINITION
> +                       Where the NNN in the pid field is the ASCII
> +                       base 10 value of the id of the process that is
> +                       executing the security event that will be
> +                       modeled.

I worry whenever I see a PID used as an identifier shared across the
kernel/userspace boundary as it is inherently racy.  Given the
somewhat coarse COE definition where one can expect multiple
processes/PIDs to share the same COE value, and the ability of
untrusted users/processes to manipulate the PID table, what do you
expect to use the pid{NNN} field for in this event?

Similar to the other namespace/mapping issues discussed previously,
there is also the PID namespace issue to worry about.  How is that
handled here?

> +                       The COE field has the same format as the field
> +                       emitted for a trajectory or forensics event.
> +
> +                       The CELL_DEFINITION are the same field
> +                       definitions that are emitted for a trajectory
> +                       or forensics event.
> +
> +               log process{name} event{type} action{type}
> +                       The log event is emitted when an untrusted
> +                       task attempts to execute a security event.
> +
> +                       The name value of the COE field is the name of
> +                       the process (comm value) that is executing the
> +                       security event.
> +
> +                       The type value of the event field is the name
> +                       of the security event being executed as
> +                       defined in the tsem_names array in the
> +                       security/tsem/tsem.c file.
> +
> +                       The type value of the action field is the type
> +                       of action the LSM enforced in response to
> +                       encountering the untrusted process.  This
> +                       value will be either LOG or EPERM to represent
> +                       whether or not the trust violation is being
> +                       logged or enforced.
> +
> +What:          /sys/fs/tsem/control
> +Date:          November 2022
> +Contact:       Greg Wettstein <greg@enjellic.com>
> +Description:
> +               The control file is the only writable file in the
> +               filesystem and is used by the trust orchestrators to
> +               configure and control the behavior of the TSEM
> +               implementation.
> +
> +               The following keyword and arguments are recognized:
> +
> +               internal:
> +                       The internal keyword causes an internally
> +                       modeled domain to be created for the calling
> +                       process.
> +
> +               external:
> +                       The external keyword causes an externally
> +                       modeled domain to be created for the calling
> +                       process.
> +
> +               enforce:
> +                       The enforce keyword causes the modeling
> +                       domain/namespace of the process to enter
> +                       enforcing mode.  In this mode a value of
> +                       -EPERM will be returned for a security event
> +                       that does not map into the current set of
> +                       allowed state points for the security model
> +                       being implemented for the domain/namespace.
> +
> +               seal:
> +                       The seal keyword causes the security model
> +                       being implemented for the model to be placed
> +                       in sealed state.  In this state the current
> +                       set of security event points is considered to
> +                       be the only set of valid points for the
> +                       domain/model.  Any subsequent events that map
> +                       to a point not in the current model will be
> +                       considered a violation of the model.
> +
> +               trusted PID:
> +                       The trusted keyword is used by a trust
> +                       orchestrator to indicate that the process
> +                       identified by the PID argument should be
> +                       allowed to run in trusted status.
> +
> +               untrusted PID:
> +                       The untrusted keyword is used by a trust
> +                       orchestrator to indicate that the process
> +                       identified by the PID argument should be
> +                       allowed to run but designated as an untrusted
> +                       process.

The 'trusted PID:' and 'untrusted PID:' commands are concerning for
the reasons described above about PIDs being racy and generally an
unreliable way of identifying processes across the kernel/userspace
boundary.  I suspect it would not be too difficult for a malicious
user to trick an external modeler into marking the wrong process as
trusted/untrusted.

> +               state HEXID:
> +                       The state keyword is used to indicate that the
> +                       security state point identified by the ASCII
> +                       base 16 encoded value should be loaded into
> +                       the current security model as a valid security
> +                       event state.
> +
> +               pseudonym HEXID
> +                       The pseudonym keyword is used to indicate that
> +                       the pathname, identified by the 256 bit ASCII
> +                       base 16 encoded value HEXID, should be
> +                       designated to return a constant digest value
> +                       for the contents of the file.
> +
> +                       The HEXID value is computed with the following
> +                       function:
> +
> +                       HEXID = SHA256(PATHNAME_LENGTH || PATHNAME)

This seems like an unusual design choice, and perhaps one born from
necessity ... ?  It's nice that it is opt-in, but I would be curious
to hear what problems this solved.

> +               base HEXID
> +                       The base keyword is used to indicate that the
> +                       256 bit ASCII base 16 encoded value HEXID
> +                       should be registered as the value used to
> +                       generate model specific security event points.
> +
> +                       A model specific base value is designed to be
> +                       used as a 'freshness' nonce, similar to an
> +                       attestation nonce, to prove that a model state
> +                       value or measurement is current and not being
> +                       replayed.
> diff --git a/Documentation/admin-guide/LSM/tsem.rst b/Documentation/admin-guide/LSM/tsem.rst
> new file mode 100644
> index 000000000000..f03e5269cd25
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/tsem.rst
> @@ -0,0 +1,1240 @@
> +====
> +TSEM
> +====

...

> +Process and Platform Trust Status
> +=================================
> +
> +A fundamental concept in TSEM is the notion of providing a precise
> +definition for what it means for a platform or workload to be trusted.
> +A trusted platform or workload is one where there has not been an
> +attempt by a process to execute a security relevant event that does
> +not map into a known security state point.
> +
> +The process trust status is a characteristic of the process that is
> +passed to any subordinate processes that are descendants of that
> +process.  Once a process is tagged as untrusted, that characteristic
> +cannot be removed from the process.  In a 'fruit from the poisoned
> +vine' paradigm, all subordinate processes created by an untrusted
> +process are untrusted as well.
> +
> +On entry into each TSEM security event handler, the trust status of a
> +process is checked before an attempt to model the event is made.  An
> +attempt to execute a security event by an untrusted process will cause
> +the event, and its characteristics, to be logged.  The return status
> +of the hook will be determined by the enforcement state of the model.
> +A permission denial is only returned if the TMA is running in
> +enforcing mode.
> +
> +If the platform running the TSEM LSM has a TPM, the hardware aggregate
> +value is computed at the time that TSEM is initialized.  This hardware
> +aggregate value is the linear extension sum over Platform
> +Configuration Registers (PCR's) 0 through 7.  This is the same
> +aggregate value that is computed by the Integrity Measurement
> +Architecture (IMA) and is the industry standard method of providing an
> +evaluation measurement of the hardware platform state.
> +
> +Internally model domains have the hardware aggregate measurement
> +included as the first state point in the security model.  Externally
> +modeled domains export the hardware aggregate value to the TMA for
> +inclusion as the first state point of the model maintained by the TMA.
> +
> +The root modeling domain extends each security state point into PCR
> +11.  This allows hardware based TSEM measurements to coexist with IMA
> +measurement values.  This hardware measurement value can be used to
> +attest to the security execution trajectory that the root model
> +maintains.

It seems like making the target PCR configurable would be a good idea,
at the very least make it a Kconfig option.

Also, can you elaborate on how the security state points are extended
into the PCR?  I imagine for it to be useful at an arbitrary point in
time this would require the PCR to be extended as the security points
were generated, which would imply that the PCR value would be
dependent on execution order, and in most cases, scheduling order as
well.  How useful do you expect this to be for most users?

> +Internal vs external modeling
> +-----------------------------
> +
> +When a TSEM modeling domain is created, a designation is made as to
> +whether the domain is to be internally or externally modeled.
> +
> +In an internally modeled domain, the security event handlers pass the
> +event type and its characteristics to the designated internal trusted
> +modeling agent.  The agent provides the permission value for the
> +security event handler to return as the result of the event and sets
> +the trust status of the process executing the event.
> +
> +In an externally modeled domain, the event type and parameters are
> +exported to userspace for processing by a trust orchestrator with an
> +associated TMA.  The trust orchestrator communicates the result of the
> +modeling back to the kernel to support the setting of the process
> +trust status.
> +
> +This model poses a limitation to the ability of TSEM to model some
> +security events.  This is secondary to the fact that some event
> +handlers (LSM hooks) are called from a non-sleeping context, as a
> +result the process cannot be scheduled.  This is particularly the case
> +with the task based hooks, since they are typically called with the
> +tasklist lock held.
> +
> +This limitation is also inherent to the root model that extends the
> +security state points into TPM PCR 11, secondary to the fact that the
> +process invoking the security event hook will be scheduled away while
> +the TPM transaction completes.
> +
> +Addressing this problem directly requires a consideration of the
> +context from which the security event handlers are being called.
> +Subsequent implementations of TSEM will include a mechanism for
> +asynchronous deferral of model processing, until when and if, a review
> +of the call context would be considered worthwhile by the LSM
> +community.

This is a pretty big limitation, and in conjunction with the some of
the other issues brought up earlier (the PID issue seems the most
concerning), I'm having a difficult time believeing that an external
modeler could operate safely given the design presented here.

Unfortunately, there will always be LSM hooks which need to operate in
a non-blocking context, meaning this challenge is here to stay.  Help
me understand how you could safely do asynchronous policy enforcement
with an external modeler, I'm not sure it's possible.

Frankly, I also wonder how a system would perform with an external
modeler, indepdent of the issues with non-blocking hooks.  How does
the system perform with every blockable LSM hook invocation
potentially blocking on a response from userspace?  Or with the COE
being somewhat coarse, does the trajectory/policy populate itself
quickly?

> +Event handlers that cannot be directly modeled, still consider, on
> +entry, whether or not they are being called by an trusted or untrusted
> +process.  As a result, an untrusted process will cause a non-modeled
> +event to return a permissions violation in enforcing mode, even if the
> +security event cannot be directly modeled.
> +
> +Security event modeling typically traps violations of trust by a COE
> +with unmodeled characteristics that is attempting to access/execute a
> +file or map memory as executable; or by a COE with known
> +characteristics attempting to access or execute a CELL not prescribed
> +by a model.  As a result, the impact of the ability to not directly
> +model these events is lessened.

...

> +Event modeling
> +--------------
> +
> +TSEM security event modeling is based on the following functional
> +definition for a security state point:
> +
> +Sp = SHA256(SHA256(EVENT_ID) || TASK_ID || SHA256(COE) || SHA256(CELL))

It appears that all of the hasing in TSEM is SHA256 based, you might
want to consider making that a Kconfig option at the very least.

> +       Where:
> +               ||       = Concatenation operator.
> +
> +               EVENT_ID = ASCII name of event.
> +
> +               TASK_ID  = 256 bit identity of the process executing
> +                          the security event.
> +
> +               COE      = Characteristics of the context of execution
> +                          of the event.
> +
> +               CELL     = Characteristics of the object that the
> +                          security event is acting on.
> +

-- 
paul-moore.com
