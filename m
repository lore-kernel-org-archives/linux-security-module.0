From: mjg59@google.com (Matthew Garrett)
Date: Wed, 04 Apr 2018 16:20:43 +0000
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <20180404125743.GB16242@thunk.org>
References: <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
	<CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
	<CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
	<CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
	<CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
	<CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
	<CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
	<CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
	<CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
	<CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
	<20180404125743.GB16242@thunk.org>
Message-ID: <CACdnJutKZL-48Ua=GYgU2vs38N5MjovP5+ENUNzVpmpi4-QFTQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 4, 2018 at 5:57 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Wed, Apr 04, 2018 at 04:30:18AM +0000, Matthew Garrett wrote:
> > What I'm afraid of is this turning into a "security" feature that ends
up
> > being circumvented in most scenarios where it's currently deployed - eg,
> > module signatures are mostly worthless in the non-lockdown case because
you
> > can just grab the sig_enforce symbol address and then kexec a preamble
that
> > flips it back to N regardless of the kernel config.

> Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> isn't this a problem for people who are fearful that Linux could be
> used as part of a Windows boot virus in a Secure UEFI context?

It does - I was talking about the non-lockdown case. In the lockdown case
you can only kexec images you trust, so there's no problem. Red Hat have
been shipping a signed kdump image for years.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
