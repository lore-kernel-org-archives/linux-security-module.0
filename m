Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DD446065
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662820; cv=pass; b=JsqFmZlnSw1uFype1ihCZUU9etr1dq5O+lXQTMHaxMT+Fvp0m0p4ia7TXqSWmCK49iqeJyeeXLtbFUm+Xbj/3I0vEIJGl0Sb33NKirs5upVpPf/STwuytl581k9a+a1gZHKpSp6u0CaTvcZ1REx4c0ipTHepLxtZ9rGkebjxWFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662820; c=relaxed/simple;
	bh=ZtPwy/QAuDnj56t2XhA2hFT5fqpBreeuRUzDplvcfDU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ugchhMIVaYtIcD9XQqKI2iXjIuaI4yf3/cOFDExlw1sMu2bhU6sek/HvQNm37th2kW3MA+WY4TNZFjeqtGNpckopySpnIJxfxCCKUyd7spwmkcts5zJzDn0NymH1pWOOy65J4ziUj3KHmPW4FyH9OL43wdL315VXC/uAQv+2tkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCUITWTY; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCUITWTY"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb61bbeb25so5858515a34.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 06:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662817; cv=none;
        d=google.com; s=arc-20260327;
        b=NNYV0QMha6B4wjuOU7U3WrTZxVx7INNG33YZue0VFPkzuw1D12CGd6RL6hMKua/EHx
         f6mwkahdDBPLYzSbVTSCip4UEjdOuTp1nXhCbNo29ymivl3UdBd+zwUbgp1YQN55dZH3
         Sx5R8uCqlNlo7vpRFwf/BhLme0nLl/MJ0M1LlWKyoLgbDdmEWjjBm6cx3UGK0K0kUGlF
         bJ4mQvz7Ja2qItyz6djpWeAib1RoR152WsefWNJJijlUN7Fi8ZXBszWizFtA21Zo2NJ8
         iqfVYdMH+vPdYii6WogRZnrettKAUJF0/UNs5DOnbk28OArBgQ9hsh+S2XXrT7BBWjJi
         rBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=k0FrjmFFQ8shgfqcbsc56ABHBtb1j8vTTf4x/8huQ/0=;
        fh=h3tPeH8S2LmQamTsDKMq7/gNLN6xaj+7E16hQlvdhHY=;
        b=GJt7mwRvs4oyWKsDcb8tPufJWhoJ5Uv7LSIFNY7/l5X5yErNE3Sazwl39FQymbWUrb
         3GwZa2T/BE7aY7RJuJ+xXbPRXKW/kGCZbaIJiadfwHJUvQYkXI/qRgxsNfD4rzJrq6lo
         K14P/zDOUmwv9UWVd8iXdR9UjUpIQB+5BTyZmGv0Ctn6g+Nm9T3KjLfbTpnH3AGBGAEC
         ViitokFvLn3HGEHgLtk3RvKjLiB09ecC2IPsUD79g3pnq+3itu+swVFVfN8v1aYCuvLJ
         JF3Xb+K8qGR9R7WdmJnHereLbs+2KGXnZ4ERDqOuvbt2X3tnhegpaIrRsm8zoe8a1mAl
         TVOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787662817; x=1788267617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0FrjmFFQ8shgfqcbsc56ABHBtb1j8vTTf4x/8huQ/0=;
        b=sCUITWTYIjg1df0LvrYYnadpyW7sI+6tttm+rp4UeHWNLjKOK5iOoen+GvHcafxPJb
         HypVDEDDUW4dpoJymPFlUKLwJhGtUG/ySS6qTvpUKQrfhR5NiIfK0P1HALwgHq4ZlYJu
         dUrZkdMQ1Iipy+4GToCzn6qIos6OBRu1KXAo9wAFLsXhs3e8EvqS0NM+8IFmO5AcFSp9
         XD3XZPmETI52oiGPWHKFyk4SsootuF8hup2VCs/ZSRkxXg4Q/VphyBAPfW70vRsnBZ12
         jaT5pZWkVHTB3C1p7Tnfk4pXq/XNF7pWXId99Kl5Vw+P44M9GdWCXdPn4IGACSZu1KzG
         9Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662817; x=1788267617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k0FrjmFFQ8shgfqcbsc56ABHBtb1j8vTTf4x/8huQ/0=;
        b=MkrcFFkP/MwXVsz7ip5+FRXUz18z23woGc5bXFVDRPWaykF2amN4fsOm5fEJH+8Lg1
         871ni/16zN2vWaSLHvtxdOPepwYaqvLPkVAJDKyQhK3IcjYxq4rJ8ZCZ0KXpOlX6ZwJE
         zDQHh2K35r2iweH69bsIFw1Xo8Ns8Ats3zii6B5MMumvF0Pwbp5HSdpWyIO6TP7wL+8P
         bKXtWyB2scZ8AQMGxG7c4vV6x3wUUcFss/EJRhMZ+FTNEkaGAl3nCXYm2xE7PRtt2p29
         kyWiXaZslgLFNrB8rDCzS2Kyd4trxEcmIYJzMoQ9FCwNxzriRjZVZqS1X8Jx3p+BsG4T
         wUrg==
X-Forwarded-Encrypted: i=1; AHgh+Ro72NXEHDo/YPKJHkJvGs7P1sJo/Jgz3bn+odHk1SCcCKKFbMRJ6mzhbtL+7CQU+EQHYNoGpBqrzVwZTarf7EtWueQdKSs=@vger.kernel.org
X-Gm-Message-State: AFuF++kOLI7mPszfhmZQBswkZrSNJDk+dB2TmaJjmqwV79sjLgyquabn
	S3GDtI2YKHdSAWVpkahiO6rq8DRPOdb8h5zV/c3hsuV2d2ObRxz6ceKPW3ARZocdffq2t6tRvJC
	ICoKbv/86vlpFT/3CIKI0HZQep/ATkjE=
X-Gm-Gg: AR+sD10U58Tzz2OW2avVtd2JI/JYWfck89ksacPXUt1dtAkBVCFDzgq41FmwuQ63OgY
	U67UqK5Ap8AYbBEZ71O0ztuJQBWxyWp6SDokfDZ8XjPg8ls/aWpua8Hm5WmL3JL6x9xkvctRbmC
	FTM7m/x5Ek7TCFJyZchnJ7gukiZEbuGndU+weXuaD6Xe0AEih6oBzLyyNp2PuP64gTgr7mvsKRT
	wWkSr+t8FuW+adYTFMEALjMC8qEyU/7XhGFZJyxYSevfAGRkwqElREpHS+s5CgqMkLeAPZDDFCZ
	wUtuatL1edeoxsTOpf6W10VO0PPVQkn0CVhYz0Te0NcP030hGx4YbYb+EWiMIsQc++IzTuTXUyw
	Fr/c=
X-Received: by 2002:a05:6820:169f:b0:6b1:2843:1309 with SMTP id
 006d021491bc7-6b190488808mr4890985eaf.26.1787662817241; Tue, 25 Aug 2026
 06:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: poppet lovelace <dmcjisalive@gmail.com>
Date: Tue, 25 Aug 2026 21:00:05 +0800
X-Gm-Features: AcwNN1WpSJ_x_cFK5WZOB6yxbnX7vpDk-_vwEKKAT5lZOZuhLlkRigJ0rR4tC9g
Message-ID: <CAL4aGcVcT0VWVFmGi_vLqxxZ9KdOHfGXYZtKjBdvoUyFjbu5=A@mail.gmail.com>
Subject: [Bug] landlock: sun_path length underflow to SIZE_MAX in
 landlock_deny_scope_abstract_unix_socket TP_printk -> unbounded OOB read in
 trace reader
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Micka=C3=ABl,

While auditing the new landlock tracepoints we found a size_t underflow in
the TP_printk() of landlock_deny_scope_abstract_unix_socket that turns a
zero-length abstract AF_UNIX address into an effectively unbounded OOB read
in the context of whoever consumes the trace (typically root reading
tracefs). The tracepoints are new in the current merge window, so this can
still be fixed before 7.3.

Root cause
----------

The event stores the abstract name correctly:

  include/trace/events/landlock.h:899-932

    __string_len(sun_path,
                 unix_sk(peer)->addr->name->sun_path + 1,
                 unix_sk(peer)->addr->len -
                     offsetof(struct sockaddr_un, sun_path) - 1)

For an abstract address bound with addrlen =3D=3D sizeof(sa_family_t) + 1 (=
=3D 3),
which net/unix/af_unix.c:335-345 (unix_validate_addr) accepts, addr->len is
3, so the stored dynamic-array length is 0.

The printer then subtracts one more:

  include/trace/events/landlock.h:954-955

    __trace_print_untrusted_str(p, __get_str(sun_path),
                                __get_dynamic_array_len(sun_path) - 1)

0u - 1 wraps to SIZE_MAX. __trace_print_untrusted_str()
(include/trace/events/landlock.h:36-68) forwards that length to
string_escape_mem(), whose main loop

  lib/string_helpers.c:586

    while (isz--) {
        unsigned char c =3D *src++;

reads every input byte regardless of output exhaustion (the escape_*
helpers stop writing past `end`, but nothing breaks the input walk). With
isz =3D=3D SIZE_MAX the read walks forward from the ring-buffer record thro=
ugh
the rest of the tracing buffer and the kernel direct map until it faults.

Impact
------

An unprivileged task inside any landlock domain that scopes abstract unix
sockets can plant such a record deterministically. The OOB read itself
executes when the trace buffer is consumed (e.g. cat of
/sys/kernel/tracing/trace or trace_pipe by a privileged monitor -- exactly
the deployment these tracepoints target):

* information disclosure: escaped bytes of adjacent kernel memory
  (ring-buffer contents and beyond, i.e. direct map) are copied into the
  visible trace text;
* availability: the walk ends in a page fault / oops in the reader's
  syscall context; with panic_on_oops this takes the whole machine down.

Same-call-site audit: the other __trace_print_untrusted_str() users subtrac=
t
1 as well (pathname :389/:725, comm :829/:878), but their captured lengths
cannot be 0 (dentry names are non-empty; comm is fixed-size), so only the
abstract-socket event is currently reachable. The -1 looks like a leftover
from string lengths that include a terminator; here the capture side alread=
y
excluded the leading abstract-name NUL.

Reproducer (hand-written, not executed against a live kernel)
-------------------------------------------------------------

  int s =3D socket(AF_UNIX, SOCK_STREAM, 0);
  struct sockaddr_un a =3D { .sun_family =3D AF_UNIX };
  a.sun_path[0] =3D '\0';                       /* abstract, zero length */
  bind(s, (struct sockaddr *)&a, sizeof(a.sun_family) + 1);   /* ok, len 3 =
*/

  /* task restricted by a domain scoping abstract unix sockets: */
  connect(cfd, (struct sockaddr *)&a, 3);     /* denied -> event recorded *=
/

  # echo 1 > /sys/kernel/tracing/events/landlock/\
landlock_deny_scope_abstract_unix_socket/enable
  # cat /sys/kernel/tracing/trace             /* OOB read here */

Self-assessed severity
----------------------

CVSS:3.1 AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:H =3D 6.7 (Medium).

If the cross-boundary read is judged Scope:Changed (kernel-memory bytes are
surfaced into user-visible trace text, and the walk can traverse the whole
direct map until it faults): AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:N/A:H =3D 7.3.
Honest range 5.5-7.3 depending on scope treatment. Preconditions: the
landlock tracepoints are enabled and consumed by a privileged reader --
i.e. exactly the monitoring deployment they were added for.

Suggested fixes (either suffices; both preferred)
-------------------------------------------------

1. Drop the "- 1" at include/trace/events/landlock.h:955 -- the capture-sid=
e
   length already excludes the abstract prefix NUL; the subtraction is a
   double decrement. Please also re-check :389/:725/:829/:878 against their
   capture lengths.
2. Harden __trace_print_untrusted_str() (or string_escape_mem()) so the
   input walk cannot exceed the source object: e.g. clamp len, or break the
   loop when output is exhausted (note this changes string_escape_mem()'s
   return-size contract for existing callers).

Found by Charles <dmcjisalive@gmail.com> -- happy to test a fix.

Thanks,
Charles

Reported-by: Charles <dmcjisalive@gmail.com>
