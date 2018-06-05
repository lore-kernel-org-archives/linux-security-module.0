From: keescook@chromium.org (Kees Cook)
Date: Tue, 5 Jun 2018 05:19:50 -0700
Subject: [PATCH v4 0/8] kexec/firmware: support system wide policy
	requiring signatures
In-Reply-To: <20180605040920.GA19747@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1528121025.3237.116.camel@linux.vnet.ibm.com>
	<CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
	<20180605040920.GA19747@mail.hallyn.com>
Message-ID: <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> enough about it to keep bikeshedding, but since this set already exists,
> it seems like the way to go.

And the new hook is "load stuff without a file descriptor"?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
