From: john.johansen@canonical.com (John Johansen)
Date: Mon, 20 Nov 2017 07:47:00 -0800
Subject: [PATCH] apparmor: initialized returned struct aa_perms
In-Reply-To: <CAK8P3a2SFStvycD4CX+4xtogaoiDXWB0tpeCDKNsYfxD9nDQcw@mail.gmail.com>
References: <20170915195620.1561044-1-arnd@arndb.de>
	<a94bac78-769a-e8bc-9a98-83a401534935@canonical.com>
	<CAK8P3a2SFStvycD4CX+4xtogaoiDXWB0tpeCDKNsYfxD9nDQcw@mail.gmail.com>
Message-ID: <4759b591-6603-7424-1758-fd0d23e6efed@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/20/2017 06:00 AM, Arnd Bergmann wrote:
> On Mon, Sep 25, 2017 at 4:29 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/15/2017 03:55 PM, Arnd Bergmann wrote:
>>> gcc-4.4 points out suspicious code in compute_mnt_perms, where
>>> the aa_perms structure is only partially initialized before getting
>>> returned:
>>>
>>> security/apparmor/mount.c: In function 'compute_mnt_perms':
>>> security/apparmor/mount.c:227: error: 'perms.prompt' is used uninitialized in this function
>>> security/apparmor/mount.c:227: error: 'perms.hide' is used uninitialized in this function
>>> security/apparmor/mount.c:227: error: 'perms.cond' is used uninitialized in this function
>>> security/apparmor/mount.c:227: error: 'perms.complain' is used uninitialized in this function
>>> security/apparmor/mount.c:227: error: 'perms.stop' is used uninitialized in this function
>>> security/apparmor/mount.c:227: error: 'perms.deny' is used uninitialized in this function
>>>
>>> Returning or assigning partially initialized structures is a bit tricky,
>>> in particular it is explicitly allowed in c99 to assign a partially
>>> intialized structure to another, as long as only members are read that
>>> have been initialized earlier. Looking at what various compilers do here,
>>> the version that produced the warning copied unintialized stack data,
>>> while newer versions (and also clang) either set the other members to
>>> zero or don't update the parts of the return buffer that are not modified
>>> in the temporary structure, but they never warn about this.
>>>
>>> In case of apparmor, it seems better to be a little safer and always
>>> initialize the aa_perms structure. Most users already do that, this
>>> changes the remaining ones, including the one instance that I got the
>>> warning for.
>>>
>>> Fixes: fa488437d0f9 ("apparmor: add mount mediation")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I've pulled this into apparmor-next
> 
> It apparently never made it into mainline. What happened?
> 
>         Arnd
> 
Its in apparmor-next and is going with today's pull request

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
