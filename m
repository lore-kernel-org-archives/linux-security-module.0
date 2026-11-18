Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023977;
	b=q+P5I3dZ8UWiO3XMS0E4PdNVG40cIP+AkEWwu/Oz79f92PnLfL4eLq4Mr5rpyJ0JB0Ia
	 4hPS/G+7vyh9ykv//s5Tu6o0Savyf/Fnbx2DxQX37Vh2uF7ObFFNsgeEGFLAMb4DmZoOA
	 m4hv4Ori/s9Arqj+N6MiHM+RC4VxgCeGGMoZeqnEJJMkKnMBSw107OODZj6hPHtVs4QVE
	 N2AkJkVrqk3x7UFSzTsS/5CKZlL2vCHgxBKcDKU7+ahDZLmX5WHXjo/eKkPOOGQ1xvF7x
	 gjQATpz/8cTGu0Q8FnQe1jgmTJr23g7MHahAB2bNCLjcT1bSZE3EOqSSnc1Qzy8cLGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SIiWqHkbikiw9/PSo57TK7nq7ydcL7CNJ2g4TYGph1w=;
	b=W/5MJsR/7spDGWfXCLMLH28F4Qwe8XrYMzU/Zmp7di9yE3K69DhDNgyQYRe//LD0nSn9
	 S9D7G4t3JxaShRcK7fwwqTusYt8RaF3QVYjPlq1Vp0uORymbwUfjrv+dDlwvizDl/bDhh
	 w/AsO0E+nYjW1UCQcxTquEMZbEWRUAwV3NWaU8gyphncHO20l4XuNavJqyzLj8FK9htAs
	 x7d4GJGjVSGTrAMJreFlK/GirxcFORT0jGdt0vkWljHr30Eg5tTVRqVeaJb66b+lGamc5
	 LU8qzwvyH2vI0v49oZWpAeF5FiRaDJcq1AkyqU53yfxJWZxlGJYhiPNEffWfpqgU3mA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="KSkreA/l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E351A606A330
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 17:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E351A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KSkreA/l
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ae0d0b9db2so13191591fa.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 09:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795023975; cv=none;
        d=google.com; s=arc-20260327;
        b=DpQrOVYmxKUgd1XJQd7LDAvVyhfJgPPeROZxUO0aYf83ep5RMZenqhlKbkEyih5Ifu
         /ejT7AzpL+wxKPChQ8eAu3R1MO3DutH1ETPE/s9NYWZPePwGGgFt9JtUKavPW5V0bIHj
         aOYPrZqlJCTotxsnYm+4CbZFv9npxNtAG/RM5CIWlx9ubp8W/7pPooqWhuJU0RrWD55A
         PCJRfR+Ys+Z807vZuyCZcdFit/Kpvm+6Cen01ORc27y0yVKLWQjy3iUdfmqUkPuhupBf
         hn0oaZyA33SB+9tGatfSjXFlBedbBjOW5yRmrapRa4OIXGpEJmHzO+F572y0CFjTy0m+
         YnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SIiWqHkbikiw9/PSo57TK7nq7ydcL7CNJ2g4TYGph1w=;
        fh=btLXiVFL+WZ5hTbVZIQkWoaW4goLx2lFUBzHXUBDHPs=;
        b=U1bqeMtMXczSpsmOCjoDCQBNOp1UMR24X18jiWTOj7TZt801uE8XAbiHytP/1eyaZs
         1CsLWVF3mlf+ZW44ueAF6F9zIaKSyue2+0BAr0xeNWN/XevuWVEp9+IX5DaQHuZRzEmH
         6r1kL9dnZPg+laFsOBB6tUKWRWKjWLk4u+ss02BkhAH23nLlYoY0O7j1btTMRs8ZYoQv
         Ho1F+2M1ZkfIdklMouMCsdR8K6QpDVuQAkw9J8Ji7Xh9h2cisdOosoIskwaW10Qzc64C
         Z8CC04ymrz22XBfBeuTTXaEQ26Qa0cUILdUIe/sXyKiAPt47w/wtumB7NYWh31ATSJu9
         0fNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795023975; x=1795628775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIiWqHkbikiw9/PSo57TK7nq7ydcL7CNJ2g4TYGph1w=;
        b=KSkreA/lv4ezsG6FIG+0z6ugqaPZfz/K227G/b9zqB4WbfNBD3XL8nHiuC3RHSDVop
         r5WQO1yWZkBKMg+zBj6fpTWLOgpJt9bMFVDdhzBzxpnWtkhvlsv4/E5kXo+obO4szmr+
         nFnhBGrEd0bPzAozYpmaEhgJtA45FnEzG5/HZEZEyKNuYbIbPoPWq9RPDZYH3gY4NHNi
         I3IElP7vq/+9MvKb/InmOXdTWMpefUYfbAAhC3j8k1680QGt9U/5fB8JA17w2EOZ287i
         CuVr1tTToajDP4e2jNTAGYhUjIUDF7CvDim1WkQKv5tAZUDy/kdf5WduxQLtE+TgPH5v
         7k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795023975; x=1795628775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIiWqHkbikiw9/PSo57TK7nq7ydcL7CNJ2g4TYGph1w=;
        b=R4fZFoPLgBf8ogItHU5pqIsAtuZrnlBWlNro8dvHb6Yt+H/E22o8UrNG3ABn0O+rBv
         XCvxh2hyHKoUUQlTb28+l7jqB27ia4XyVS/qX5O9sCtcF5X+M99dEfHvGgDM87gjhXwj
         DBiNZb6T2DWB1Cmpmq0tkqm5zMg8qjMQLAzPgHarEqKHB08ug7FgL5j2LQ6APFU0oqE6
         O+P01jmlxCc55uMOOlmJe3GtelBNDfrcZtHmihf+Jxl4NWMauwPvTOTwVVEddfUjZinM
         luSpyxZ1zyqWD/bwE/ZlqV0XYQ7uITdcksMUzAOJLQc2BoHovSpFbDyeoDagMR/kQ4Ta
         3xVA==
X-Forwarded-Encrypted: i=1; AL+hErE7OHKJK+Mr90ju2ZtrIK8f8cwGmqfpYCaZhux6WAmBBzCJjs/0SFuuo8dMjdTGChcYlY0A8/JBKlfN+f+svnpndUKvc+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Abgky5ct2oqwexIPCFyjUw1jKlnUlC7K9Sm8URoehJ0szbAR9
	h/uTC+BWteRTRVX4og9/1SiePUQ21nZkzAqUd/dLwmOiwo/EbJvy/iJAwb4tBg9CAhsAN721+kE
	4vzqai5CKl9HYqv6MJNDKdz/DzOuqboYokFbJZjYY
X-Gm-Gg: AYBFou2yV4+FN/ZQoTh+FQSG3c5iYrb1Hag359fIoKntzuMeP8kU/l+/9cKEzttp8Qb
	qL+l+2+iW3xEMQRM7rZu/0VebzJF2LZ4tea6tei+cyS2C5xdjfe7Q/o59EDj/K9v2GXL0jy6rOp
	pxwjXlnGQWw5jB2bvy95U3MZO0KaMMxR3XIsZQzTD0UvbkOGvLJOE2kFS1EoIRYyc3lYqhLSI+p
	erhkYil/bEZA8PAG6z2a/KkiM31KVKYR+1LCzRGQWCKFz2HXRZilsj3no45dUjsua0Hu6ydF+/5
	+RIt4f9NjIyjOxqCUMJAvngCHUpdK1IZcWOVQPJ/kWnoLorNXN1Gv+VO19wu/+01U2PHujiqOEr
	QxkTabRA7l+CgIVDxvtROWtHiQzFATWPezQ==
X-Received: by 2002:a05:6512:8346:b0:5c1:ac84:c105 with SMTP id
 2adb3069b0e04-5c1ac84c2a0mr745576e87.57.1795023975125; Wed, 18 Nov 2026
 09:46:15 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117231352.3816603-1-jarkko@kernel.org> <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
In-Reply-To: <av3bkDnwmjunTleX@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Nov 2026 09:46:02 -0800
X-Gm-Features: Aa3M54rqJXQt69c6byOctTWRaXx3nXcFQskBrnHvxsTyM3qw4EOZDCkVbvK6iJk
Message-ID: <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	John Johansen <john.johansen@canonical.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Kees Cook <kees@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Zygmunt Krynicki <zygmunt.krynicki@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 9:08=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Nov 18, 2026 at 07:04:21PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Nov 18, 2026 at 08:59:39AM -0800, Andy Lutomirski wrote:
> > > On Tue, Nov 17, 2026 at 3:14=E2=80=AFPM Jarkko Sakkinen <jarkko@kerne=
l.org> wrote:
> > > >
> > > > OVERVIEW
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > A root namespace (rootns) is a kernel object backed by a file descr=
iptor
> > > > that binds together:
> > > >
> > > > 1. A full or partial set of detached namespaces.
> > > > 2. A dedicated PID namespace for spawning processes into, signaling
> > > >    members, and polling or waiting on PID 1 exit.
> > > > 3. An initially empty mount namespace (CLONE_EMPTY_MNTNS) that must=
 be
> > > >    populated before going live, without inheriting host mount-tree
> > > >    ancestors.
> > > >
> > > > Work on this feature started in 2025 from David Howells' container =
object
> > > > patch set [1], which I turned into a namespace for namespace roots =
and
> > > > rebuilt around that premise.
> > > >
> > > > While the patch set is manually written, the original motivation ca=
me
> > > > from isolating LLM agents. Running untrusted agent workloads made i=
t
> > > > clear that OCI runtimes need to minimize their live configuration
> > > > surface.
> > > >
> > > > Assembling mounts, credentials, and namespaces inside helper proces=
ses
> > > > with a half-configured container is what I see as the main challeng=
e,
> > > > and the existential debate around namespaces and container objects =
is an
> > > > unfocused discussion topic.
> > >
> > >
> > > I've skimmed some of the series, and I see a bunch of good ideas that
> > > involve using an fd to manage a thing.  But I'm wondering how much of
> > > the value is added by that and how much is added by having a new
> > > *type* of thing: the "rootns".
> > >
> > > How much of the value comes from the rootns vs the new APIs to
> > > configure namespaces without entering them first?
> > >
> > > For that matter, the cells series also seems to contain a (possibly
> > > very similar) variant of the same thing.
> > >
> > > Would it make sense to come up with a patchset that does *just* the
> > > configure-a-namespace-by-fd part?  It seems to me that this should be
> > > an easier thing to agree on, and it's a big part of the complexity of
> > > all of this, and it solves a real problem even without
> > > cells/rootnses/jails/whatever.
> >
> > Is it  more accurately scope the part that is "just the fd-part" and
> > what you consider as "extra cruft"?

I'm not actually trying to say that anything is "extra cruft".  What I
mean is: there seems to be somewhat of a core that is pretty similar
between the two patchsets, and that core seems independently useful.

> >
> > I.e., where do you draw the border?
>
> I'm asking this because I had similar thoughts when I started this back
> in 2025. David had some good ideas but it did more than having a fd
> that does not go live before everything is set up properly.

I don't know that I have a very clear border, but here's an example:

rootns has MOVE_MOUNT_T_ROOTNS_ROOT.

cells has:

+What else goes into the tree is mounted on it before it becomes a
mount namespace.  A
+filesystem for the cell to write to is mapped in the same way:
+
+.. code-block:: c
+
+   fs =3D fsopen("tmpfs", 0);
+   fsconfig(fs, FSCONFIG_SET_STRING, "mode", "1777", 0);
+   fsconfig(fs, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
+   mnt =3D fsmount(fs, 0, MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV);
+   mount_setattr(mnt, "", AT_EMPTY_PATH, &attr, sizeof(attr));
+   move_mount(mnt, "", tree, "tmp", MOVE_MOUNT_F_EMPTY_PATH);

(Source: https://lore.kernel.org/all/20261105-b4-cells-v3-2-bc9095937a84@to=
xicpanda.com/)

I feel like you are both *so close* to something that would stand
alone and make perfect sense.  I also feel like, if that's a goal,
then both series are slightly off from the bulls-eye.  (Keep in mind
that I've spend a total of about ten minutes looking at the relevant
parts of the series.)

If I've understood the two series correctly, and if I'm thinking of
these abilities as something that can stand alone, then I see the
following things that I'd improve.

rootns: Why can't I use a *mountns* fd to so the configuration?  Maybe
I'm misunderstanding something.

cells: The dance where I create an anonymous mountns, mount stuff into
it, and then attach it to the cell is cute.  But I think the userns
interaction is wrong: you are making me assemble all the mounts in
*my* userns and then clone the entire tree into a fresh, non-anonymous
mountns bound to the current userns.  And that clone operation is not
free and serves no actual practical purpose.

Why can't there be some variant of these where I can either create an
anonymous mount tree that is genuinely unbound from a userns or that
lives in *the target userns* or that *is already the final mountns*,
using just mount-related APIs?  In pseudocode:

int mountns_control_fd =3D create_mountns(either userns-free or with a
userns_control_fd);
fsopen, move_mount, , open_tree, etc;

Finally:

cells: I find it *incredibly annoying* that one generally cannot put
new mounts into an existing container using most existing container
managers.  I hit this on a surprisingly regular basis.  You seem to be
baking this into the whole cells design.  Why?

both of you: Can we please make it possible to do the parts of this
that oughtn't require privilege without privilege?  If the cap_userns
thing ever lands, cap_userns & CAP_SYS_ADMIN ought to be more than
sufficient to permit creating fresh mounts even without creating a
userns as long as we don't do anything that affects privileges within
our own userns.  Or let us create a userns, *not enter it*, and do all
the mounting without actually having CAP_SYS_ADMIN in the permitted
set.


--=20
Andy Lutomirski
AMA Capital Management, LLC
