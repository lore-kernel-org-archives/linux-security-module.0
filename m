From: tytso@mit.edu (Theodore Y. Ts'o)
Date: Wed, 4 Apr 2018 09:52:51 -0400
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <24353.1522848817@warthog.procyon.org.uk>
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
	<CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
	<CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
	<CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
	<CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
	<CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
	<CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
	<CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
	<CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
	<24353.1522848817@warthog.procyon.org.uk>
Message-ID: <20180404135251.GD16242@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 04, 2018 at 02:33:37PM +0100, David Howells wrote:
> Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> > isn't this a problem for people who are fearful that Linux could be
> > used as part of a Windows boot virus in a Secure UEFI context?
> 
> Lockdown mode restricts kexec to booting an authorised image (where the
> authorisation may be by signature or by IMA).

If that's true, then Matthew's assertion that lockdown w/o secure boot
is insecure goes away, no?

							- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
