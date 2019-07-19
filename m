Return-Path: <SRS0=Y89O=VQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B0AC76195
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C992173B
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 12:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfGSMPo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:15:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfGSMPo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jul 2019 08:15:44 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BA7B928C59C;
        Fri, 19 Jul 2019 13:15:42 +0100 (BST)
Date:   Fri, 19 Jul 2019 13:15:40 +0100
From:   Simon McVittie <smcv@collabora.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
Message-ID: <20190719121540.GA1764@horizon>
References: <2517266.eHZzEmjMsX@x2>
 <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <20190718131034.GA12581@horizon>
 <45661e97-2ed0-22e5-992e-5d562ff11488@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45661e97-2ed0-22e5-992e-5d562ff11488@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 18 Jul 2019 at 09:13:52 -0700, Casey Schaufler wrote:
> We have discussed what's currently being
> called the "hideous" format, selinux='a:b:c:d',apparmor='x' which
> in the past, and concluded that the compatibility issues would be too
> great.

I agree this might be too big a compat break for existing interfaces that
were designed with the assumption that there can only be one "big" LSM
at a time, like /proc/54321/attr/current and SO_PEERSEC. It would certainly
break the current libapparmor, and presumably libselinux as well.

However, I think it would be great to have multiple-"big"-LSM-aware
replacements for those interfaces, which present the various LSMs as
multiple parallel credentials.

I think it would also be valuable to take this opportunity to pin down
what can and can't be in a label, to an extent where people who want
to represent them in a similar encoding know what they can and can't
assume about their format. For example, when dbus-daemon reports an
unusual event (like rejecting a message due to policy rules or LSMs,
or hitting a resource limit that isn't normally meant to be reached),
the log entry contains miscellaneous information about the process for
debugging purposes, and it would be good if we could include all the LSM
labels in that string without ambiguity. This is essentially the same
problem that the audit subsystem has, but with fewer constraints, since
the audit subsystem has to meet externally-imposed security requirements
but our equivalent is just a nice-to-have for debugging.

> Have you been following the discussions on setting a "display" value
> to specify which LSM data is presented by /proc/self/attr/current and
> SO_PEERSEC? Briefly, a process can write the name of the LSM it wants
> to see data from to /proc/self/attr/display, and the aforementioned
> interfaces will use that LSM. If no value has been set the first LSM
> registered that uses any of these interfaces gets the nod.

I'm vaguely aware of the discussion, but LSMs aren't a big part of my
D-Bus maintainer role, so I'm afraid I can't keep up with all of it.

Do you mean that if process 11111 writes (for example) "apparmor" into
/proc/11111/attr/display, and then reads /proc/22222/attr/current
or queries the SO_PEERSEC of a socket opened by process 22222,
it will specifically see 22222's AppArmor label and not 22222's SELinux
label? Or is the contents of /proc/22222/attr/current controlled
by /proc/22222/attr/display?

How is this meant to work for generic LSM-aware user-space processes? If
(for example) ps -Z 22222 wants to get both the AppArmor label and the
SELinux label for process 22222, is it meant to write "apparmor" into
attr/display, then read /proc/22222/attr/current, then write "selinux"
to attr/display, then read /proc/22222/attr/current again? That sounds
risky if another thread might be manipulating attr/display concurrently.

The D-Bus message bus/broker (reference implementation: dbus-daemon)
is somewhat tricky because it is returning data on behalf of processes
other than itself, so it would be difficult for it to choose a good
value for "display": there's no reason why it wouldn't be responding
to requests from NetworkManager that expect to see SELinux labels, and
also requests from lxd that expect to see AppArmor labels. Obviously
it can't put both in LinuxSecurityLabel without the same compatibility
issues you're discussing.

Also note that dbus-daemon is trusted but mostly unprivileged - it
starts as root, then drops privileges to a system user normally called
messagebus, dbus or _dbus for its normal operation (although it does
retain CAP_AUDIT_WRITE) - so it can't carry out privileged operations
on other processes' /proc entries, if that's what the API requires.

I would strongly prefer it if we could get this information from
the kernel in a way that is Linux-specific but LSM-agnostic, without
having to link to libapparmor, libselinux, libsmack and everyone else's
favourite LSM library. At the moment we only need to link to libraries
for the LSMs where dbus-daemon can carry out mediation (asking the LSM
whether to accept or reject messages), and we don't need the libraries
if we are just passing through identity information.

I would also prefer it if we can get this information from SO_PEERSEC
(or some newer SO_PEERSEC replacement) without having to manipulate
ambient/implicit state like attr/display; but dbus-daemon is
single-threaded, so if we must do that, it wouldn't be *so* horrible.

Ideally I would like to be able to get all the LSM labels in O(1)
syscalls. Perhaps something with the same (buffer,length) kernel <->
user-space API as SO_PEERSEC and SO_PEERGROUPS, but instead of returning
a single \0-terminated string, it could return either the "hideous" format,
or a byte-blob that looks something like this?

    char buffer[ENOUGH_LENGTH] = { 0 };
    socklen_t len = sizeof (buffer);
    char[] expected =
    "apparmor=unconfined\0"
    "selinux=system_u:system_r:init_t:s0\0"
    "\0"
    ;

    getsockopt (fd, SOL_SOCKET, SO_PEERSECLABELS, &buffer, &length);
    /* should return 0 */
    /* now buffer should have the same bytes as expected, ending with
     * "\0\0" */

(Obviously in real life you'd have a retry loop to get the length right,
like the SO_PEERSEC code in dbus does.)

Because GetConnectionCredentials() is extensible, if there is some way
to enumerate all the security labels and get their values individually,
we could have (pseudocode)

GetConnectionCredentials(":1.1") -> {
  "UnixUserID": 0,
  "ProcessID": 1,
  "LinuxSecurityLabel.apparmor": "unconfined",
  "LinuxSecurityLabel.selinux": "system_u:system_r:init_t:s0",
  "LinuxSecurityLabel": "unconfined",    /* deprecated */
}

or (using D-Bus' structured type system)

GetConnectionCredentials(":1.1") -> {
  "UnixUserID": 0,
  "ProcessID": 1,
  "LinuxSecurityLabels": {
    "apparmor": "unconfined",
    "selinux": "system_u:system_r:init_t:s0",
  },
  "LinuxSecurityLabel": "unconfined",    /* deprecated */
}

with LinuxSecurityLabel showing the first LSM registered for backwards
compatibility? Or we could make LinuxSecurityLabel always be in the
"hideous" format if you chose to go that way in the kernel interfaces:
it's defined in terms of SO_PEERSEC, so whatever you do at the kernel
level, D-Bus should mimic that.

    smcv
