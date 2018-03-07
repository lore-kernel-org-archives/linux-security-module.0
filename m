From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 7 Mar 2018 09:40:31 -0800
Subject: [PATCH v4 0/3] Safe, dynamically loadable LSM hooks
In-Reply-To: <cover.1520407240.git.sargun@sargun.me>
References: <cover.1520407240.git.sargun@sargun.me>
Message-ID: <d2b31866-def9-dd2a-766c-b55ebbff9f8a@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/6/2018 11:22 PM, Sargun Dhillon wrote:
> This patchset introduces safe dynamic LSM support. These are currently
> not unloadable, until we figure out a use case that needs that. Adding
> an unload hook is trivial given the way the patch is written.

If I recall correctly (it's been a decade since the discussion)
one of the reasons for not having loadable security modules was
that no one had a good idea on how they might be unloaded safely.
I'm not 100% convinced that there are no cases where you might
want to load a module that you can't unload, but I can definitely
come up with scenarios where it could be harmful.

> This exposes a second mechanism of loading hooks which are in modules.
> These hooks are behind static keys, so they should come at low performance
> overhead. The built-in hook heads are read-only, whereas the dynamic hooks
> are mutable.

I don't like having two mechanisms and I really don't like the
way you replace the structure of hooks with an array of pointers.

> Not all hooks can be loaded into. Some hooks are blacklisted, and therefore
> trying to load a module which plugs into those hooks will fail.

Which hooks, and why?

> One of the big benefits with loadable security modules is to help with
> "unknown unknowns". Although, livepatch is excellent, sometimes, a
> surgical LSM is simpler.

I could buy this if you could unload the module when the surgery
is done. As it is, you are stuck with whatever restrictions you
have introduced forever.

> It includes an example LSM that prevents specific time travel.
>
> Changes since v3:
>   * readded hook blacklisted
>   * return error, rather than panic if unable to allocate memory
>
> Changes since v2:
>   * inode get/set security is readded
>   * xfrm singleton hook readded
>   * Security hooks are turned into an array
>   * Security hooks and dynamic hooks enum is collapsed
>
> Changes since v1:
>   * It no longer allows unloading of modules
>   * prctl is fixed
>   * inode get/set security is removed
>   * xfrm singleton hook removed
>
>
> Sargun Dhillon (3):
>   security: Refactor LSM hooks into an array and enum
>   security: Expose a mechanism to load lsm hooks dynamically at runtime
>   security: Add an example sample dynamic LSM
>
>  include/linux/lsm_hooks.h | 459 ++++++++++++++++++++++++----------------------
>  samples/Kconfig           |   6 +
>  samples/Makefile          |   2 +-
>  samples/lsm/Makefile      |   4 +
>  samples/lsm/lsm_example.c |  33 ++++
>  security/Kconfig          |   9 +
>  security/inode.c          |  13 +-
>  security/security.c       | 222 ++++++++++++++++++++--
>  8 files changed, 508 insertions(+), 240 deletions(-)
>  create mode 100644 samples/lsm/Makefile
>  create mode 100644 samples/lsm/lsm_example.c
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
