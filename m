Return-Path: <SRS0=Y89O=VQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57007C7618F
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1365221872
	for <linux-security-module@archiver.kernel.org>; Fri, 19 Jul 2019 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mcrdT71E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfGSQ3V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:29:21 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:43591
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727577AbfGSQ3V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jul 2019 12:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563553757; bh=3XJz1EMebhAnByro7T3uiT24PczRcyvRBajVwerk0rE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mcrdT71E7nWHkGNKUpvYvTkz8QhnpbXMiTmpN1fmT83E908w0Kaldpj/WMmvNI1a1L/lXIoJTXzdOXTKa6JukzT8vLJV0cQaoRYjgbqTxeaGUy9dDbRA3CFwVKhqi3A19A5mUGROvNzL7MdCszz+pKcfJqEuHMsGcqXBhN+HZ4LzYVzgrfQqpfVE6ULPFCfbccbIjRhzye+lFBXs31aOdQVlj8tKD5C5hBF+YPOF4eBAmHDjhhuraK/sL+jBWGiyja9Kekc0DTZ4B1dHqqVcHWzUQchCyjoDNYh/uWKRlA48hNmkiNXS5eP+u3KpQKNUTF4QUCOnkExLI/9aAr7Tvg==
X-YMail-OSG: j8fcgosVM1nVS2L5DWvgE_G3nf5HKbR2RajUqXa9rkHJZifPl1wwWMs3QV8DxCG
 WBW2aoMOkCoCgz86KBBb._fig9uCjqlFUhET5wtLkQq9x0YL8wZ.PHPX4MtWfUG9LX7yAiamDYqO
 Utftm1jPWLU9mDk.leE.dHRcSF.Hb41HYaP1VddTTiXoa9V4wOzv8o_zqWv2_Sf2v.__3nCSx9ED
 R5ZD20NuhcGKRvqqzKZKSW8xeLsc1zihFkHu59IAQpRQNw8tsl8aBvZTkRI51O_PdH4ecSA_Yf7h
 uSS0xrKMvML8VFbG.w9s1AjuavCNaPBUXTHP4bgLsmYFAsOw.rMErjzP2Soxi25wbzyTZhxcaIAI
 iNdWGUKUrOkV5QshXPyBATre9_yprAtZcJX4uZbxX5V6IEQA_FIHOichkTiJnQ5p88ANzb.UF0A3
 XOx4TNRBsGimoi7N0t4EByvCUoGLc_umfSJ1tFustX3ZRK2Yb6qYjLFcR9l1bVB1._ydPVlEkfcn
 qqUdOExuJsbO6ksGm.lPe6aoCbK.RpMTNPIMSCXo5ymsB5z.1SsMWX45Cj8wwLw0OfkTEUT.5e0Q
 rs2ij_IjGmYR..2t60y_iEa6Orj6zfIrf7A70JQKJbhvi9RkR_t.gRWzEfJ6gUBr2HyzUChm._kZ
 9kZMT8ox77htPUwfR5sKJ6m3ecJ1D.cnssgxBA1rTegKiRuGI47BgXo0Rsg8LkAm52h.QGzmy0_y
 kZrIyjCMyEwEvFTFQuxtz5992r_zZmd74.4Jpvp6IYQUF4dO7ZSOrhUF_Y_a0vBrF1mxmluT75Jv
 MAOVq.Rslu1kgXKcsEG0m804I_Muj2IIuBoRv44l440oJDTVnyuh0R1wGmWrWF5WqE6yv6hkmkr_
 kzkh3neyfF.RjY9SKz1w4SpP0FjZ293V3dDPUDbu5Jr3sbY3D5vQjUI52_jGoE8OcapedrFnmrNZ
 nUPOcso8iyWxoL2FpdZbK_sFq0ETPUSqpgbX6SvyNv1kNS6lSCMm7NRYuiDSsygisup6N8_B1xsC
 JvkaT7ZTCNIaklsA3mhwwEAjMlIOu7aUktPZwFEoXDs3oM.S7uPlKPKquJhePq7gbgGLsltTN2yB
 ImDEuWA4n7_zzAnzUDGogmZUo2JATApK4CyiMRInI8NTzO5DPTCSNzzId.vu7uGKwSKIzdY41Gs7
 l7uYyxKfEtgOBwi9QajCkP.2xswcyZMVoIZJuMNRvFs0JzZgkmduQsvuLNgTU.tmhDSSWvF3mRCg
 G9IrvMA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Jul 2019 16:29:17 +0000
Received: by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7e5be3ec72392f683f1e604fcf2df451;
          Fri, 19 Jul 2019 16:29:16 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     Simon McVittie <smcv@collabora.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
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
 <20190719121540.GA1764@horizon>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <720880ca-834c-1986-3baf-021c67221ae2@schaufler-ca.com>
Date:   Fri, 19 Jul 2019 09:29:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719121540.GA1764@horizon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/19/2019 5:15 AM, Simon McVittie wrote:
> On Thu, 18 Jul 2019 at 09:13:52 -0700, Casey Schaufler wrote:
>> We have discussed what's currently being
>> called the "hideous" format, selinux=3D'a:b:c:d',apparmor=3D'x' which
>> in the past, and concluded that the compatibility issues would be too
>> great.
> I agree this might be too big a compat break for existing interfaces th=
at
> were designed with the assumption that there can only be one "big" LSM
> at a time, like /proc/54321/attr/current and SO_PEERSEC. It would certa=
inly
> break the current libapparmor, and presumably libselinux as well.
>
> However, I think it would be great to have multiple-"big"-LSM-aware
> replacements for those interfaces, which present the various LSMs as
> multiple parallel credentials.

Defining what would go into liblsm* is a task that has fallen to
the chicken/egg paradox. We can't really define how the user-space
should work without knowing how the kernel will work, and we can't
solidify how the kernel will work until we know what user-space
can use.

---
* I absolutely refuse to allow this to be libsecurity!

> I think it would also be valuable to take this opportunity to pin down
> what can and can't be in a label, to an extent where people who want
> to represent them in a similar encoding know what they can and can't
> assume about their format. For example, when dbus-daemon reports an
> unusual event (like rejecting a message due to policy rules or LSMs,
> or hitting a resource limit that isn't normally meant to be reached),
> the log entry contains miscellaneous information about the process for
> debugging purposes, and it would be good if we could include all the LS=
M
> labels in that string without ambiguity. This is essentially the same
> problem that the audit subsystem has, but with fewer constraints, since=

> the audit subsystem has to meet externally-imposed security requirement=
s
> but our equivalent is just a nice-to-have for debugging.

Sounds like the Hideous format, or a variant thereof, would be
fine for you, especially if you never parse it.

>> Have you been following the discussions on setting a "display" value
>> to specify which LSM data is presented by /proc/self/attr/current and
>> SO_PEERSEC? Briefly, a process can write the name of the LSM it wants
>> to see data from to /proc/self/attr/display, and the aforementioned
>> interfaces will use that LSM. If no value has been set the first LSM
>> registered that uses any of these interfaces gets the nod.
> I'm vaguely aware of the discussion, but LSMs aren't a big part of my
> D-Bus maintainer role, so I'm afraid I can't keep up with all of it.
>
> Do you mean that if process 11111 writes (for example) "apparmor" into
> /proc/11111/attr/display, and then reads /proc/22222/attr/current
> or queries the SO_PEERSEC of a socket opened by process 22222,
> it will specifically see 22222's AppArmor label and not 22222's SELinux=

> label? Or is the contents of /proc/22222/attr/current controlled
> by /proc/22222/attr/display?

Process 11111 would see the AppArmor label when reading
/proc/22222/attr/current. The display value is controlled
by process 11111 so that it can control what data it wants
to see.

> How is this meant to work for generic LSM-aware user-space processes? I=
f
> (for example) ps -Z 22222 wants to get both the AppArmor label and the
> SELinux label for process 22222, is it meant to write "apparmor" into
> attr/display, then read /proc/22222/attr/current, then write "selinux"
> to attr/display, then read /proc/22222/attr/current again? That sounds
> risky if another thread might be manipulating attr/display concurrently=
=2E

The display is set at the task level, so should be thread safe.

> The D-Bus message bus/broker (reference implementation: dbus-daemon)
> is somewhat tricky because it is returning data on behalf of processes
> other than itself, so it would be difficult for it to choose a good
> value for "display": there's no reason why it wouldn't be responding
> to requests from NetworkManager that expect to see SELinux labels, and
> also requests from lxd that expect to see AppArmor labels. Obviously
> it can't put both in LinuxSecurityLabel without the same compatibility
> issues you're discussing.

Just so.

> Also note that dbus-daemon is trusted but mostly unprivileged - it
> starts as root, then drops privileges to a system user normally called
> messagebus, dbus or _dbus for its normal operation (although it does
> retain CAP_AUDIT_WRITE) - so it can't carry out privileged operations
> on other processes' /proc entries, if that's what the API requires.

Writing to display does not require privilege, as it affects only
the current process. The display is inherited on fork and reset on
a privileged exec.

> I would strongly prefer it if we could get this information from
> the kernel in a way that is Linux-specific but LSM-agnostic, without
> having to link to libapparmor, libselinux, libsmack and everyone else's=

> favourite LSM library. At the moment we only need to link to libraries
> for the LSMs where dbus-daemon can carry out mediation (asking the LSM
> whether to accept or reject messages), and we don't need the libraries
> if we are just passing through identity information.

I can see that making dbus-daemon have to decide which label of many
to pass on to its clients would be bad.

> I would also prefer it if we can get this information from SO_PEERSEC
> (or some newer SO_PEERSEC replacement) without having to manipulate
> ambient/implicit state like attr/display; but dbus-daemon is
> single-threaded, so if we must do that, it wouldn't be *so* horrible.

An option that hasn't been discussed is a display option to provide
the Hideous format for applications that know that's what they want.
Write "hideous" into /proc/self/attr/display, and from then on you
get selinux=3D'a:b:c:d',apparmor=3D'z'. This could be used widely in libl=
sm
interfaces.

> Ideally I would like to be able to get all the LSM labels in O(1)
> syscalls. Perhaps something with the same (buffer,length) kernel <->
> user-space API as SO_PEERSEC and SO_PEERGROUPS, but instead of returnin=
g
> a single \0-terminated string, it could return either the "hideous" for=
mat,
> or a byte-blob that looks something like this?
>
>     char buffer[ENOUGH_LENGTH] =3D { 0 };
>     socklen_t len =3D sizeof (buffer);
>     char[] expected =3D
>     "apparmor=3Dunconfined\0"
>     "selinux=3Dsystem_u:system_r:init_t:s0\0"
>     "\0"
>     ;
>
>     getsockopt (fd, SOL_SOCKET, SO_PEERSECLABELS, &buffer, &length);
>     /* should return 0 */
>     /* now buffer should have the same bytes as expected, ending with
>      * "\0\0" */
>
> (Obviously in real life you'd have a retry loop to get the length right=
,
> like the SO_PEERSEC code in dbus does.)

I would see creating a friendly interface like this as part of
my mythical liblsm, but I see your point.

> Because GetConnectionCredentials() is extensible, if there is some way
> to enumerate all the security labels and get their values individually,=

> we could have (pseudocode)
>
> GetConnectionCredentials(":1.1") -> {
>   "UnixUserID": 0,
>   "ProcessID": 1,
>   "LinuxSecurityLabel.apparmor": "unconfined",
>   "LinuxSecurityLabel.selinux": "system_u:system_r:init_t:s0",
>   "LinuxSecurityLabel": "unconfined",    /* deprecated */
> }
>
> or (using D-Bus' structured type system)
>
> GetConnectionCredentials(":1.1") -> {
>   "UnixUserID": 0,
>   "ProcessID": 1,
>   "LinuxSecurityLabels": {
>     "apparmor": "unconfined",
>     "selinux": "system_u:system_r:init_t:s0",
>   },
>   "LinuxSecurityLabel": "unconfined",    /* deprecated */
> }
>
> with LinuxSecurityLabel showing the first LSM registered for backwards
> compatibility? Or we could make LinuxSecurityLabel always be in the
> "hideous" format if you chose to go that way in the kernel interfaces:
> it's defined in terms of SO_PEERSEC, so whatever you do at the kernel
> level, D-Bus should mimic that.

If providing the Hideous format makes library code easier or more
efficient I'm happy to make that happen. It can't be the default due to
backward compatibility, but it can be easy as
"echo hideous > /proc/self/attr/display".

>
>     smcv

